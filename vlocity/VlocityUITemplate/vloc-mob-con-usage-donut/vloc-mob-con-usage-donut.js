vlocity.cardframework.registerModule.controller('usageDonutController',
                ['$scope', '$rootScope',
                function($scope, $rootScope) {
        
        var totalUsage = 0;
        var vm = this;
        //$scope.offset = 500;
        vm.selectedSegment = 0;
        vm.usagePercent = 0;
        vm.usageSection = '';
        vm.payload = [];

        vm.init = function(payload){
            vm.payload = payload;
            for(var i = 0; i < payload.length; i++){
                totalUsage += payload[i].expr0;
            }
            
            $scope.totalUsage = totalUsage;
            var circtotal = 500 - (payload.length*10);
            console.log('Inside init ', new Date());

            for(var j = 0; j < payload.length; j++){
                payload[j].circleamount = (((payload[j].expr0 / totalUsage) * circtotal)+10).toFixed(0);
                if(j === 0)
                    payload[j].offset = 0;
                else if(j == 1)
                    payload[j].offset = 500 - payload[j-1].circleamount;
                else
                    payload[j].offset = payload[j-1].offset - payload[j-1].circleamount;
            }
           
            vm.highlightDonut(0);
        }
        
        vm.selectDonutSegment = function(index, elem) {
            this.selectedSegment = index;
            this.highlightDonut(index);
        }
        
        vm.highlightDonut = function(donutId) {
            this.usagePercent = Math.round((this.payload[donutId].circleamount)/5);
            this.usageSection = this.payload[donutId].%vlocity_namespace%__ServiceName__c;
            console.log('this.usageSection ', this.usageSection);
        }
        
        $rootScope.$on('hightlightDonut', function(event, item) {
            vm.highlightDonut(item);
        });
        
}]);