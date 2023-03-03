vlocity.cardframework.registerModule.controller('searchItemsDiscountTplController', ['$rootScope','$scope','CPQService','$sldsTypeahead','$http','CPQTranslateService','CPQSettingsService', 'CPQDiscountService', function($rootScope, $scope, CPQService, $sldsTypeahead, $http, CPQTranslateService, CPQSettingsService, CPQDiscountService) {
        $scope.searchResults = [];
        $scope.arrayOfProducts =[];
        $scope.arrayOfCatlogs =[];
        var actionMode = CPQService.actionMode;
        var vlocCPQ;
        var localeCode;
        var customSettings = CPQSettingsService.getCustomSettings();

        var arrayOfProducts = $scope.$watch('arrayOfProducts', function(newValue) {
            CPQDiscountService.setTotalProducts($scope.arrayOfProducts);
            arrayOfProducts();
        }, true);

        var arrayOfCatlogs = $scope.$watch('arrayOfCatlogs', function(newValue) {
            CPQDiscountService.setTotalCatlogs($scope.arrayOfCatlogs);
            arrayOfCatlogs();
        }, true);

        $scope.addSelectedSearchProduct = function(parent, index) {
               if ($scope.searchResults[index].productId) {
                    $scope.arrayOfProducts.push($scope.searchResults[index]);
               } else {
                   $scope.arrayOfCatlogs.push($scope.searchResults[index]);
               }
               
        };

        $scope.deleteSelectedItem = function(index) {
            $scope.arrayOfProducts.splice(index, 1);
        }

        $scope.deleteSelectedCatlog = function(index) {
            $scope.arrayOfCatlogs.splice(index, 1);
        }

        $scope.searchItem = "";

        $scope.getSearchItems = function(obj, viewValue) {
            var searchActionObj = obj.actions;
            localeCode = window.vlocCPQ && window.vlocCPQ.userLocale;
            if (!viewValue) {
                return;
            }

            searchActionObj.remote.params.query = viewValue;
            searchActionObj.rest.params.query = viewValue;
            // adding localCode so API will search product only in translated values
            if (customSettings.EnableMultiLanguageSupport) {
                searchActionObj[actionMode].params.localeCode = localeCode;
            }

            return CPQService.invokeAction(searchActionObj).then(
                function(data) {
                    $scope.searchResults = data.records;
                    //translation of produc
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
                '<li ng-repeat="match in $matches" ng-class="{active: $index == $activeIndex}">'+
                    '<a href="javascript:void(0);" class="slds-lookup__item-action" role="menuitem" tabindex="-1" ng-click="addSelectedSearchProduct(records, $index, $event)" >'+
                        '<div class="slds-col slds-size--6-of-12 slds-p-horizontal--x-small slds-truncate" title="{{match.label}}">{{match.label}}</div>'+
                    '</a>'+
                '</li>'+
            '</ul>'+
        '</div>';
}]);