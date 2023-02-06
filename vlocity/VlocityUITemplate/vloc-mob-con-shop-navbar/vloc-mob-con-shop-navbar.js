vlocity.cardframework.registerModule.controller('shopController',
                ['$scope', '$state', '$location', '$rootScope', '$timeout', function($scope, $state, $location, $rootScope, $timeout) {

        "use strict";
        
        // required section
        // to listen to any object changes in the parent scope
        $scope.vm = Object.assign($scope, $scope.parent);
        
        var broadcastReceiver = $scope.$on('UniversalObjectUpdate', function(payload) {
            console.log("updates object", payload);
            $scope.vm = Object.assign($scope, $scope.parent);
        });

        $scope.$on('$destroy', function () {
            broadcastReceiver();
            console.log("removed receiver");
        });
        
        // end of required section

        $scope.vm.interaction = function() {
            alert("sample interaction");
        }
        
        
        /*this.viewDetail = function(name) {
                    console.log('OS', $rootScope);
                    $state.go('app.univ', {
                    objectId: '' + $rootScope.currentUser.Account.attributes.url.substring(38),
					type: 'MobConBasket'
				});
              
        };*/
        
        this.viewDetail = function(name) {
                    $state.go('app.univ', {
                    objectId: '' + $rootScope.currentUser.Account.attributes.url.substring(38),
					type: 'MobConBasket'
				});
              
        };





}]);