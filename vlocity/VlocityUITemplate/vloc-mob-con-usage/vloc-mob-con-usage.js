vlocity.cardframework.registerModule.controller('usageController',
    ['$scope', '$rootScope', function($scope, $rootScope) {
        
        var topData = 1;
        var topTalk = 1;
        var topText = 1;
        var thresholdData = 0;
        var thresholdTalk = 0;
        var thresholdText = 0;
        var vm = this;
        this.selectedTab = 1;
        this.nsPrefix = $scope.nsPrefix;
        var nsPrefix = $scope.nsPrefix;
        
        this.init = function(payload) {
            for(var i = 0; i < payload.length; i++){

                //Find highest usage or theshold
                if(payload[i].expr0 > topData && payload[i][nsPrefix+'Type__c'] == 'Data'){
                    topData = payload[i].expr0;
                }
                if(payload[i].expr1 > topData && payload[i][nsPrefix+'Type__c'] == 'Data'){
                    topData = payload[i].expr1;
                }
                if(payload[i].expr0 > topTalk && payload[i][nsPrefix+'Type__c'] == 'Talk'){
                    topTalk = payload[i].expr0;
                }
                if(payload[i].expr1 > topTalk && payload[i][nsPrefix+'Type__c'] == 'Talk'){
                    topTalk = payload[i].expr1;
                }
                if(payload[i].expr0 > topText && payload[i][nsPrefix+'Type__c'] == 'Text'){
                    topText = payload[i].expr0;
                }
                if(payload[i].expr1 > topText && payload[i][nsPrefix+'Type__c'] == 'Text'){
                    topText = payload[i].expr1;
                }
                
                //Find threshold
                if(payload[i].expr1 > thresholdData && payload[i][nsPrefix+'Type__c'] == 'Data'){
                    thresholdData = payload[i].expr1;
                    console.log('thresholdData ', thresholdData);
                }
                if(payload[i].expr1 > thresholdTalk && payload[i][nsPrefix+'Type__c'] == 'Talk'){
                    thresholdTalk = payload[i].expr1;
                }
                if(payload[i].expr1 > thresholdText && payload[i][nsPrefix+'Type__c'] == 'Text'){
                    thresholdText = payload[i].expr1;
                }
            }
            
            $scope.topData = topData;
            $scope.topTalk = topTalk;
            $scope.topText = topText;
            $scope.thresholdData = thresholdData;
            $scope.thresholdTalk = thresholdTalk;
            $scope.thresholdText = thresholdText;
            
            function debounce(func, wait, immediate) {
                var timeout;
                return function() {
                    var context = this, args = arguments;
                    var later = function() {
                        timeout = null;
                        if (!immediate) func.apply(context, args);
                    };
                    var callNow = immediate && !timeout;
                    clearTimeout(timeout);
                    timeout = setTimeout(later, wait);
                    if (callNow) func.apply(context, args);
                };
            }
            
            var showGraphFn = debounce(function() {
                var elements = document.querySelector('.con-usage-graph');
                if (elements && elements.getBoundingClientRect()) {
                    if (elements.getBoundingClientRect().top < (window.innerHeight / 3) * 2) {
                        elements.classList.remove('con-usage-graph-small');
                    } else {
                        elements.classList.add('con-usage-graph-small');
                    }
                }
            });
            
            var scrollContentContainers = document.querySelectorAll(".scroll-content");
            for (var j = 0; j < scrollContentContainers.length; j++) {
                scrollContentContainers[j].addEventListener("scroll", showGraphFn);
            }
        }
            
        
        $rootScope.$on('tabSelected', function(event, index) {
            vm.selectedTab = index;
        })

}]);