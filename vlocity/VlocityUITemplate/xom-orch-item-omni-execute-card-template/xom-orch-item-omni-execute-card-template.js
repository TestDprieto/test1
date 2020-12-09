vlocity.cardframework.registerModule
    .controller('omniActionExecController',
                 ["$scope","$rootScope","$window","$location","dataService", function( $scope,$rootScope,$window,$location,dataService){
        this.init = function(params){
            if (params && typeof params.id != 'undefined') {
                var nsPrefix = $rootScope.nsPrefix;
                var url;
                var itemId = params.id;
            
                var query = 'select id, Name, CustomTaskExecutionURL__c, OrchestrationItemType__c from OrchestrationItem__c where id = \'' + params.id + '\' limit 1';
                dataService.getRecords(query).then(
                    function (records) {
                        $scope.record = records[0];
                        console.log('Record: ', $scope.record);
                        $scope.itemType = $scope.record[nsPrefix+'OrchestrationItemType__c'];
                        customTaskExecUrl = $scope.record[nsPrefix+'CustomTaskExecutionURL__c'];
                        if(customTaskExecUrl) {
                            console.log('Bingo!');
                            url = customTaskExecUrl;
                            console.log('customTaskExecUrl', url);
                            url = url.toString().replace(/\{0\}/g, $scope.record.Id);
                            $scope.url = url;
                        } 
                        else {                            
                            $scope.errorMessage = "Sorry! There is no task to execute.";
                        }
                    }
                ); 
            }
        };

        this.performAction =  function (action) {
            var url = $scope.url;
            var nsPrefix = $rootScope.nsPrefix;
            if (url){
                var isInConsole = (window.sforce && sforce.one);
                action[nsPrefix + 'URL__c']=url;
                if (isInConsole){
                    action[nsPrefix + 'OpenUrlMode__c']="Current window";
                }
                $scope.performAction({
                    type: 'Custom',
                    isCustomAction: true,
                    url: url,
                    openUrlIn: action[nsPrefix + 'OpenUrlMode__c']
                });
            }
        }//performAction
}]);