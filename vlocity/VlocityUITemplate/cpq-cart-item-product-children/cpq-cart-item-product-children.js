vlocity.cardframework.registerModule.controller('searchItemsTplController', ['$rootScope','$scope','CPQService','$sldsTypeahead','$http','CPQTranslateService','CPQSettingsService', function($rootScope, $scope, CPQService, $sldsTypeahead, $http, CPQTranslateService, CPQSettingsService) {
        $scope.searchResults = [];
        var vlocCPQ;
        var localeCode;
        var customSettings = CPQSettingsService.getCustomSettings();

        /* Custom Labels */
        $scope.customLabels = {};
        var labelsArray = ['CPQMTM','CPQ2YContract','CPQSearch'];
        CPQService.setLabels(labelsArray, $scope.customLabels);

        $scope.addSelectedSearchProduct = function(parent, index) {
            var selectedChildProductToBeAdded = $scope.searchResults[index];
            $scope.$parent.$parent.addToCart(parent, selectedChildProductToBeAdded);
        };

        $scope.searchItem = "";

        $scope.getSearchItems = function(obj, viewValue) {
            var searchActionObj = obj.actions.getproducts;
            var inCartQuantityMap = obj[$rootScope.nsPrefix + 'InCartQuantityMap__c'];

            localeCode = window.vlocCPQ && window.vlocCPQ.userLocale;
            if (!viewValue) {
                return;
            }

            searchActionObj.remote.params.query = viewValue;
            searchActionObj.rest.params.query = viewValue;
            // adding localCode so API will search product only in translated values
            if (customSettings.EnableMultiLanguageSupport) {
                searchActionObj.remote.params.localeCode = localeCode;
                searchActionObj.rest.params.localeCode = localeCode;
            }

            if (typeof inCartQuantityMap != 'undefined') {
                searchActionObj.remote.params.inCartQuantityMap = inCartQuantityMap;
                searchActionObj.rest.params.inCartQuantityMap = inCartQuantityMap;
            }

            return CPQService.invokeAction(searchActionObj).then(
                function(data) {
                    $scope.searchResults = data.records;
                    //translation of product name
                    if (customSettings.EnableMultiLanguageSupport) {
                        if (angular.isDefined(data.records)) {
                            data.records = CPQTranslateService.translateProductList(data.records);
                        }
                    }
                    return data.records;
                }, function(error) {
                    $log.error('Search response failed', error);
                });
        };

        $scope.typeaheadTemplate = '<div class="slds-lookup__menu slds-size--1-of-1" ng-show="$isVisible()" style="margin-top:-16px;">'+
            '<ul tabindex="-1" class="slds-lookup__list" role="menu">'+
                '<li ng-if="$matches.length > 0">'+
                    '<div class="slds-lookup__item-action" style="cursor:text;">'+
                        '<div class="slds-col slds-size--6-of-12 slds-p-horizontal--x-small slds-truncate">&nbsp;</div>'+
                        '<div class="slds-col slds-size--3-of-12 slds-text-align--right slds-p-horizontal--small">{{::customLabels.CPQMTM}}</div>'+
                        '<div class="slds-col slds-size--3-of-12 slds-text-align--right slds-p-horizontal--small">{{::customLabels.CPQ2YContract}}</div>'+
                    '</div>'+
                '</li>'+
                '<li ng-repeat="match in $matches" ng-class="{active: $index == $activeIndex}">'+
                    '<a href="javascript:void(0);" class="slds-lookup__item-action" role="menuitem" tabindex="-1" ng-click="addSelectedSearchProduct(records, $index, $event)" >'+
                        '<div class="slds-col slds-size--6-of-12 slds-p-horizontal--x-small slds-truncate" title="{{match.label}}">{{match.label}}</div>'+
                        '<div class="slds-col slds-size--3-of-12 slds-text-align--right slds-p-horizontal--small">{{match.index}}</div>'+
                        '<div class="slds-col slds-size--3-of-12 slds-text-align--right slds-p-horizontal--small">{{match.value | currency}}</div>'+
                    '</a>'+
                '</li>'+
            '</ul>'+
        '</div>';
}]);