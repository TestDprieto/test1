vlocity.cardframework.registerModule.controller('osController',
                ['$scope', '$rootScope', '$state', '$timeout', function($scope, $rootScope, $state, $timeout) {

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

        this.viewDetail = function(name) {
                    $state.go('app.univ', {
                    objectId: '',
					type: 'MobConHelp'
				});
              
        };

}]);