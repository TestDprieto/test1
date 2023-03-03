vlocity.cardframework.registerModule.controller('donutChartController',
                ['$scope', '$state', '$rootScope', '$ionicHistory', '$ionicSideMenuDelegate', '$timeout', '$ionicConfig',
                function($scope, $state, $rootScope, $ionicHistory, $ionicSideMenuDelegate, $timeout, $ionicConfig) {

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

        //Draw Graph
        $scope.drawGraph = function(data) {
            if(data.obj.expr1 !== 0){
                var fillPercentage = Math.round((data.obj.expr0 / data.obj.expr1)*100);
                if(fillPercentage > 100){
                    fillPercentage = 100;
                }
                $('.con-donut-chart-' + data.cardIndex + ' .con-device-details-donut-graph-data').html(fillPercentage + '%');
                fillPercentage = 190 - Math.round((data.obj.expr0 / data.obj.expr1)*190)
                if(fillPercentage < 0){
                    fillPercentage = 0;
                }
                $('.con-donut-chart-' + data.cardIndex + ' .circle_animation').attr('stroke-dashoffset', fillPercentage);
            }
        };

}]);