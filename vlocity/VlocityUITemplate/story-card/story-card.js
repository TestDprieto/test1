vlocity.cardframework.registerModule
    .controller('viaTaskController',
                ['$scope','force', '$rootScope', '$filter', function($scope, force, $rootScope, $filter) {
        
        $scope.setCardIcon = function() {
            var icon = $scope.session.objAPIName ? $scope.session.objAPIName : ($scope.obj.objType ? $scope.obj.objType : $scope.obj.objAPIName); 
            $scope.cardIcon = $rootScope.cardIconFactory(icon + ' ' + ($scope.obj.highlight ? $scope.obj.highlight : '') + ' ' + $scope.obj.title);
        };
        
        $scope.updateTask = function(id, value, obj) {
            obj.loading = true;
            force.update('task', {Id: id, Status: value})
                .then(
                function(response) {
                    delete obj.loading;
                },
                function(error) {
                    alert('Task could not be updated due to server error');
                    delete obj.loading;
                }
            );
        };

        $scope.openStory = function(obj) {
            var toBeLaunchedUrl = obj.navigateLink || ('/' + obj.Id)
            $scope.performAction({
                type: 'Custom',
                isCustomAction: true,
                url: toBeLaunchedUrl,
                openUrlIn: 'New Tab / Window'
            });
        };

    }]);