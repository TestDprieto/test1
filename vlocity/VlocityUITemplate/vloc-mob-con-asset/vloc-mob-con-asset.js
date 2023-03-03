vlocity.cardframework.registerModule.controller('assetPageController',
                ['$scope', '$state', '$rootScope', '$ionicSideMenuDelegate',
                function($scope, $state, $rootScope, $ionicSideMenuDelegate) {
 
        $scope.vm = Object.assign($scope, $scope.parent);
 
        $scope.vm.toggleSideMenu = function() {
            $ionicSideMenuDelegate.toggleLeft();
        }
        
        this.viewDetail = function(name) {
                    $state.go('app.univ', {
					type: name
				});
              
        };

}]);