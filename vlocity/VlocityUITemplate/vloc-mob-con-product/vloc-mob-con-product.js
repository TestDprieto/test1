vlocity.cardframework.registerModule.controller('productController',
                ['$scope','$rootScope','dataSourceService',
                function($scope,$rootScope,dataSourceService) {

        $scope.isDisabled = false;
        this.addToCart = function(pid, oid){
            $('.con-product-button').addClass('con-product-button-added');
            $('.con-product-button').html('Added');
            $scope.isDisabled = true;
            var datasource = {};
            datasource.type = 'ApexRemote';
            datasource.value = {
                remoteNSPrefix: $rootScope.nsPrefix,
                remoteClass: 'IntegrationProcedureService',
                remoteMethod: 'VlocityMobileConsumer_AddProductToCart',
                inputMap: {
                    ProductId: pid,
                    OrderId: oid
                }
            };
            dataSourceService.getData(datasource, $scope, null).then(
                function(data) {
                    console.log('Success:',data);
                },
                function(error) {
                    console.error('Error:',error);
                });
        }

}]);