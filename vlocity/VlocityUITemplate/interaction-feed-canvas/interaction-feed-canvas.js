vlocity.cardframework.registerModule
    .controller('interactionFeedCardController',
                ['$scope', '$timeout', '$interval', '$filter',
                    function($scope, $timeout, $interval, $filter) {
        $scope.$watch(function() {
            return $scope.records ? $scope.records.length : 0;
        }, function() {
            if ($scope.records) {
                $scope.records.forEach(function(record) {
                    if (record.Type === 'Viewed') {
                        record.Icon = 'preview';
                    } else if (record.Type === 'Launched') {
                        record.Icon = 'new_window';
                    } else if (record.Type === 'Step') {
                        record.Icon = 'layout';
                    } else if (record.Type === 'Call Out') {
                        record.Icon = 'sort';
                    }
                    // format Ellapsedtime:
                    if(record.Elapsedtime)
                        record.Elapsedtime = $scope.formatTime(record.Elapsedtime);
                });
            }
        });
        
        $scope.formatTime = function(time) {
            var formattedTime;
            time = parseInt(time);
            if (time >= 1000) {
                formattedTime = (time / 1000).toFixed(2).toString() + 's';
            } else {
                formattedTime = time.toString() + 'ms';
            }
            return formattedTime;
        };
        
        $scope.refreshFrame = function(){
            window.location.reload();
        }
    }]);