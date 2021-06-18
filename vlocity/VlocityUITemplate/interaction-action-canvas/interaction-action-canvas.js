vlocity.cardframework.registerModule.controller('InteractionActionController', ['$scope' , 'remoteActions', '$rootScope' , '$timeout', function($scope, remoteActions, $rootScope, $timeout) {
        $scope.namespacePrefix = $rootScope.nsPrefix;
        $scope.notification = {};
        $scope.$watch(function() {
            return $scope.records ? $scope.records.length : 0;
        }, function() {
            $scope.interactionId = window.interactionId || $scope.params.id;
            if ($scope.records) {
                $scope.interactionObj = $scope.records;
            }
        });
        
        $scope.interactionAction = function(type) {
        	if (type === 'Completed') {
        		$scope.interactionObj.fieldValueMap[$scope.namespacePrefix + 'Status__c'] = 'Completed';
        	}
        	else if (type === 'Cancel') {
        		$scope.interactionObj.fieldValueMap[$scope.namespacePrefix + 'Status__c'] = 'Cancel';
        	}
        	$scope.dateStringToUTC();
    
            remoteActions.updateTask($scope.interactionObj, $scope.interactionId).then(function(result) {
                if (type === 'Completed') {
                    $scope.notification.message = 'The interaction has been set to Complete. The Console Primary Tab will close in 3 seconds...';
                } else if (type === 'Cancel') {
                    $scope.notification.message = 'The interaction has been Cancelled. The Console Primary Tab will close in 3 seconds...';
                }
                $timeout(function() {
                     if(sforce.console && sforce.console.isInConsole()) {
                            sforce.console.getEnclosingPrimaryTabId($scope.closePrimaryTab);
                        } else if(typeof sforce.one === 'object') {
                            if ('parentIFrame' in window) {
                                parentIFrame.sendMessage({
                                    message:'actionLauncher:closePrimaryTab'
                                });
                            }
                        }
                }, 3000);
            }, function(error){
                console.log('Updating task status error: ' + error.message);
                $scope.notification.message = error.message || error.data.message;
            });         
        };
    
        $scope.dateStringToUTC = function() {
        	for ( var field in $scope.datetimeDisplay) {
        		$scope.interactionObj.fieldValueMap[field] = new Date($scope.datetimeDisplay[field]).toISOString();
        	}
        };
        $scope.closePrimaryTab = function(result) {
            console.log('Primary tab id: ', result.id);
            sforce.console.closeTab(result.id);
        };
}]);