vlocity.cardframework.registerModule.controller('widgetLongArrowController',
                ['$scope', '$state', '$rootScope', '$timeout', '$ionicConfig',
                function($scope, $state, $rootScope, $timeout, $ionicConfig) {

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
        
        //Navigate to a new page
        this.viewDetail = function(name) {
                    $state.go('app.univ', {
					objectId: '',
					pageTitle: '',
					type: name
				});
              
        };
}]);