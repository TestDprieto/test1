vlocity.cardframework.registerModule
    .controller('ShopProductController',
                 ['$scope', '$state', '$rootScope', 'MobileService', function($scope, $state, $rootScope, MobileService) {
            
            this.viewDetail = function(obj) {
                    $state.go('app.univ', {
					objectId: '' + obj.name,
					type: 'MobConProduct'
				});
            };
}]);