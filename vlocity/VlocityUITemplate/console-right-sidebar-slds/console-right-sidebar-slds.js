vlocity.cardframework.registerModule.controller('consoleRightSideBarController', ['$scope', '$rootScope', 'timeStampInSeconds','actionService', 'pageService', '$localizable', 'performAction', '$log', function($scope, $rootScope, timeStampInSeconds, actionService, pageService, $localizable, performAction, $log) {
        // Your code goes here
        $scope.recordId = pageService.params.id;
        
        $scope.init = function () {

            function load(result, type) {
                type = type ? type : 'ConsoleCards';
                // in the case user creates a new account, there is no account id,
                // so the rest should not be loaded.
                // console sets result.id to a string with "null" value when creating new Acount
                if (result.id === 'null') {
                    $rootScope.entitySelected = false;
                    return;
                } else {
                    result.Id = result.id;
                }

                //special case for interaction ID when we need to fetch the account ID
                //check for interactionId result
                if($scope.$parent.records && $scope.$parent.records.length > 0) {
                    result.id = $scope.$parent.records[0].Id; //acct ID
                }

                // As part of CARD-185, we are using params.id in cards which contains account id.
                $rootScope.accountId = $scope.accountId = result.id;
                $rootScope.entitySelected = true;
                //we no longer pass the objType as we differ it inside of apex to make Console Cards actions agnostic
                actionService.getActions(null, result, null, type, $rootScope.forcetkClient, $log).then(
                    function(action){
                        $scope.consoleCardsAction = action;
                        if($scope.consoleCardsAction.length === 0){
                            console.error('Either Vlocity Action has not been setup or it is not activated, so cards cannot be presented');
                            return;
                        }
                        console.log('action completed:',$scope.consoleCardsAction);
                        if(sforce.console && sforce.console.isInConsole()) {
                            sforce.console.getEnclosingPrimaryTabId(openSubtab);
                        } else if(typeof sforce.one === 'object') {
                            openSubTabsForLightning();
                        }
                       
                });

            }

            if(sforce.console && sforce.console.isInConsole()) {
                console.info('inside console');
                sforce.console.getEnclosingPrimaryTabObjectId(load);
            } else if(typeof sforce.one === 'object') {
                console.info('lightning console');
                var result = { id: $scope.recordId };
                load(result, 'LEXConsoleCards');
            } else {
                console.info('outside console');
                var result = { id: $scope.recordId };
                load(result);
            }
        };
            
        $scope.init();

        var openSubtab = function openSubtab(result) {
            $scope.primaryTabId = result.id;
            var subTabName = $scope.consoleCardsAction['name'];
            sforce.console.getSubtabIds($scope.primaryTabId , showTabId);
        };

        var openSubTabsForLightning = function(){
            angular.forEach($scope.consoleCardsAction, function(action){
                var extraParams = {};
                extraParams = _.assign(extraParams, action.extraParams);
                var actionConfig = {};
                actionConfig.extraParams = extraParams;
                return performAction(action, actionConfig, null, null, null, null);
            });
        };

        var focusSuccess = function focusSuccess(result) {
            console.log('openSuccess:',result);
            if (!result.success || originalLayoutName !== consoleCardsActionLayoutName) {
                // AccountConsoleCards subtab is NOT open. We need to open a new one and focus it OR layoutName changed
                angular.forEach($scope.consoleCardsAction, function(action){
                    var originalLayoutName = localStorage.getItem('consoleCardsLayoutName');
                    var url = action.url;
                    var consoleCardsActionLayoutParams = url.substring(url.indexOf('&layout')).split('=');
                    var consoleCardsActionLayoutName = consoleCardsActionLayoutParams[1];
                    var tabLabel = action['displayName'];
                    var subTabName = action['name'];
                    sforce.console.openSubtab($scope.primaryTabId, url, true, tabLabel, null, openSuccess, subTabName);
                });
            }
        };

        var showTabId = function showTabId(result) {
            //Display the subtab IDs
            var subtabId = localStorage.getItem('subtabId');
            if(result.ids.indexOf(subtabId) > -1){
            } else {
                var subTabName = $scope.consoleCardsAction['name'];
                sforce.console.focusSubtabByNameAndPrimaryTabId(subTabName, $scope.primaryTabId,focusSuccess);
            }
        };

        var openSuccess = function openSuccess(result) {
            if(result.success){
                var subtabId = localStorage.getItem('subtabId');
                if(subtabId != result.Id){
                    localStorage.setItem('subtabId',result.id);
                    sforce.console.focusSubtabById(result.id);
                }
            }
        };

        // this will prevent the sidebar in loading itself twice, reducing api calls by 50%
        var eventHandler = function eventHandler(result) {
           // just do nothing so I do not refresh :)
        };
        if(sforce.console && sforce.console.isInConsole()) {
            sforce.console.onEnclosingTabRefresh(eventHandler);
        }
}]);