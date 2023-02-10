vlocity.cardframework.registerModule
    .controller('AssetSummaryController',
                 ['$scope', '$state', '$rootScope', 'MobileService', function($scope, $state, $rootScope, MobileService) {

            this.viewDetail = function(obj) {
                    $state.go('app.univ', {
					objectId: obj.Id,
					pageTitle: obj.Name,
					type: 'RETAssetDetail'
				});
              
        };
}]);