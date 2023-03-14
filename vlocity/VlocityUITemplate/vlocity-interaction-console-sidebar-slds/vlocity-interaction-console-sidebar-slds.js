vlocity.cardframework.registerModule.controller('interactionConsoleSidebarController', ['$scope', '$rootScope', 'timeStampInSeconds','dataService', 'pageService', '$localizable', 'performAction', function($scope, $rootScope, timeStampInSeconds, dataService, pageService, $localizable, performAction) {
        // Your code goes here
        $scope.recordId = pageService.params.id;
        
        $scope.init = function () {

            function load(result) {

                // in the case user creates a new account, there is no account id,
                // so the rest should not be loaded.
                // console sets result.id to a string with "null" value when creating new Acount
                if (result.id === 'null') {
                    $rootScope.entitySelected = false;
                    return;
                }

                // As part of CARD-185, we are using params.id in cards which contains account id.
                $rootScope.accountId = $scope.accountId = result.id;
                $rootScope.entitySelected = true;
                //we no longer pass the objType as we differ it inside of apex to make Console Cards actions agnostic
                dataService.getConsoleCardsAction(null, result.id, $rootScope.forcetkClient).then(
                    function(action){
                        $scope.consoleCardsAction = action;
                        if($scope.consoleCardsAction.length === 0){
                            console.error('Either Vlocity Action has not been setup or it is not activated, so cards cannot be presented');
                            // the reason we are launching the error message below using alert() rather than $modal is
                            // because it is launched from the sidebar and $modal is constrained by the size of the
                            // sidebar, which may not have enough space to display the entire message.  By using alert(),
                            // the error prompt will be in the middle of the screen and would be big enough to diaply the
                            // entire message
                            alert($localizable('ConsoleCardsActionConfigureError', 'Either Vlocity Action has not been setup or it is not activated, so cards cannot be presented.  There must be a Vlocity Action configured with the name ConsoleCards and it must have been activated'));
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
                load(result);
            } else {
                console.info('outside console');
                var result = { id: $scope.recordId };
                load(result);
            }
        };
        
        $rootScope.relaunchVerifiedCaller = function(recordId, interactionid, searchType, eventName) {               
            var focusedTabId, data;
            sforce.console.getFocusedPrimaryTabId(function(result) {
                 //console.log(result);
                 focusedTabId = result.id;
                 data = {
                        //tabId: focusedTabId,
                        recordId: recordId,
                        interactionId:interactionid,
                        searchType: searchType
                    };
                    console.log('relaunch verified caller data: ', data);
                    console.log('eventName', eventName);
                    sforce.console.fireEvent(eventName, angular.toJson(data));
                });
        };
        
        $rootScope.verifyCallerFromConsole = function(recordId, interactionid,searchType, eventName) {
            var focusedTabId, data;
            sforce.console.getFocusedPrimaryTabId(function(result) {
                //console.log(result);
                focusedTabId = result.id;
                data = {
                    //tabId: focusedTabId,
                    recordId: recordId,
                    interactionId:interactionid,
                    searchType: searchType
                };
                console.log(data);
                sforce.console.fireEvent(eventName, angular.toJson(data));
            });
        };
            
        $rootScope.displaySearchResults = function(recordId, interactionid,searchType, eventName) {
            var focusedTabId, data;
            sforce.console.getFocusedPrimaryTabId(function(result) {
                //console.log(result);
                focusedTabId = result.id;
                data = {
                    //tabId: focusedTabId,
                    recordId: recordId,
                    interactionId:interactionid,
                    searchType: searchType
                };
                console.log(data);
                sforce.console.fireEvent(eventName, angular.toJson(data));
            });
        };
        
        $rootScope.launchInteractionWidget = function(param, eventName) {
            sforce.console.getFocusedPrimaryTabId(function(result) {
                //console.log(result);
                focusedTabId = result.id;
                data = {
                    //tabId: focusedTabId,
                    param: param,
                    policyNum: $rootScope.policyNum,
                };
                console.log(data);
                sforce.console.fireEvent(eventName, angular.toJson(data));
            });
        };
            
        // Listen for done event:
        if(sforce.console && sforce.console.isInConsole()) {
            sforce.console.addEventListener('via-interaction-done', function(e) {
                var data = e.message;
                console.log('Heard "via-interaction-done". Here is data passed through: ', data);
            });
        }
            

        $scope.init();

        var openSubtab = function openSubtab(result) {
            $scope.primaryTabId = result.id;
            var subTabName = $scope.consoleCardsAction['name'];
            sforce.console.getSubtabIds($scope.primaryTabId , showTabId);
            //sforce.console.focusSubtabByNameAndPrimaryTabId(subTabName, $scope.primaryTabId,focusSuccess);
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

            // detect if the consoleCardActions layout name has changed such that a new
            // layout will be used in the ConsoleCards (if not user has to close the account
            // and select the same account again in order for ConsoleCards to reflect change
            // of layout name being used)
            // var originalLayoutName = localStorage.getItem('consoleCardsLayoutName');
            // var url = $scope.consoleCardsAction.url;
            // var consoleCardsActionLayoutParams = url.substring(url.indexOf('&layout')).split('=');
            // var consoleCardsActionLayoutName = consoleCardsActionLayoutParams[1];
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
                // var tabLabel = $scope.consoleCardsAction['displayName'];
                // var subTabName = $scope.consoleCardsAction['name'];
                // sforce.console.openSubtab($scope.primaryTabId, url, true, tabLabel, null, openSuccess, subTabName);
            }
        };

        var showTabId = function showTabId(result) {
            //Display the subtab IDs
            var subtabId = localStorage.getItem('subtabId');
            if(result.ids.indexOf(subtabId) > -1){
                // console.error('found the tab ');
            } else {
                // console.error('didnt find it, open it');
                var subTabName = $scope.consoleCardsAction['name'];
                sforce.console.focusSubtabByNameAndPrimaryTabId(subTabName, $scope.primaryTabId,focusSuccess);
            }
        };

        var openSuccess = function openSuccess(result) {
            // console.error('opening subtab');
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