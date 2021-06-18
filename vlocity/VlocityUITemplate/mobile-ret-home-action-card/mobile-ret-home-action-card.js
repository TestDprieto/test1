vlocity.cardframework.registerModule
    .controller('RetHomeActionController',
                 ['$scope', '$timeout', '$location', '$rootScope', 'MobileService', function($scope, $timeout, $location, $rootScope, MobileService) {

            this.createOrder = function(action) {
                var nsPrefix = $rootScope.nsPrefix;
                var url = action[nsPrefix + 'Url__c'] || action[nsPrefix + 'URL__c'] || action.url;

                if(_.isEmpty(_.get($rootScope.retailAppData, "orderId"))){
                    MobileService.showAlert({
                        title: 'Error',
                        template: "OrderId doesn't exist, make sure turn on EnableRetailApp in mobile configuration."
                    });
                } else {
                    url =  _.replace(url, new RegExp('{cartId}', 'gi'), $rootScope.retailAppData.orderId);
                          
                    $timeout(function() {
                            $location.path(url);
                    }); 
            }
        };
}]);