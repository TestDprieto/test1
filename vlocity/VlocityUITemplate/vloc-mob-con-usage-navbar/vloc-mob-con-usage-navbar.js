vlocity.cardframework.registerModule.controller('viaMobileNavBarController',
                ['$scope', '$rootScope', '$timeout', function($scope, $rootScope, $timeout) {

        "use strict";
        
        // required section
        // to listen to any object changes in the parent scope
        $scope.vm = Object.assign($scope, $scope.parent);
        $scope.tabIndex = 1;
        
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
        
        $scope.selectUsageTab = function (tabIndex) {
            $scope.tabIndex = tabIndex;
            $rootScope.$broadcast('tabSelected', tabIndex);
            $rootScope.$broadcast('hightlightDonut', 0);
        }
        
        $scope.tabList = [
            {'title': 'Data', id: 1},
            {'title': 'Talk', id: 2},
            {'title': 'Text', id: 3}
        ];
}]);