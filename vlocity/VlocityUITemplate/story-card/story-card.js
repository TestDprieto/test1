vlocity.cardframework.registerModule
    .controller('viaTaskController',
                ['$scope','force', '$rootScope', '$filter', function($scope, force, $rootScope, $filter) {

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
                openUrlIn: (window.sforce && sforce.console && sforce.console.isInConsole() ? 'New Tab / Window' : null)
            });
        };

    }]);