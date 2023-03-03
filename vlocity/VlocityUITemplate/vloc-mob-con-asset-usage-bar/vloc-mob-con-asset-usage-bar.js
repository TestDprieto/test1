vlocity.cardframework.registerModule.controller('barChartController',
                ['$scope',
                function($scope) {

        //Draw Graph
        $scope.drawGraph = function(data) {
            if(data.obj.expr1 !== 0){
                var fillPercentage = Math.round((data.obj.expr0 / data.obj.expr1)*100);
                if(fillPercentage > 100){
                    fillPercentage = 100;
                }
                $('.con-bar-chart-' + data.cardIndex + ' .con-device-details-bar-graph-chart-fill').css('width',fillPercentage + '%');
            }
        };

}]);