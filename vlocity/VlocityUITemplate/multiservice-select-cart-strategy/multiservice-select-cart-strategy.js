vlocity.cardframework.registerModule.controller('CartStrategyController', ['$scope', 'remoteActions',
    function($scope, remoteActions) {
        /*
         * custom labels
         */
        var customLabels = ['MSQuotingType', 'MSOrderType', 'MSSingleQuote', 'MSMultiQuote', 'MSMultiQuoteDesc', 'MSSingleQuoteDesc',
                                            'MSSingleOrder', 'MSMultiOrder', 'MSMultiOrderDesc', 'MSSingleOrderDesc'];
        /*
         * custom labels map.
         */ 
        $scope.customLabelsMap = {};
        /*
         * next button id.
         */
        var nextButtonId = 'SelectQuotingType_nextBtn';
        /*
         * keep watch on selected options.
         */ 
        $scope.$watch('bpTree.response.selectedCartStrategy', function (newValue, oldValue) {
            if(newValue) {
                nextButton(false);
            } else {
                nextButton(true);
            }
        });
        $scope.$watch('bpTree.response.cartType', function (newValue, oldValue) {

            if (newValue && !$scope.cartType) {
                $scope.cartType = newValue.toLowerCase();
            }
        });
        
        /*
         * controller init.
         */ 
        $scope.init = function() {
            getCustomLabels();
        }

        function getCustomLabels() {

            remoteActions.getCustomLabels(customLabels, '').then(
                function (result) {
                    if(result) {
                        $scope.customLabelsMap = angular.fromJson(result);
                    }
                }
            );
        }
        /*
         * next button disable/enable.
         */
        function nextButton(disable) {

            if(!nextButtonId) {
                return;
            }

            if(disable) {
                angular.element(document.getElementById(nextButtonId)).css({'pointer-events': 'none', 'cursor': 'default', 'background': '#c9c7c5'});
            } else {
                angular.element(document.getElementById(nextButtonId)).css({'pointer-events': 'auto', 'cursor': 'pointer', 'background': '#0070d2'});
            }
        }
    }
]);