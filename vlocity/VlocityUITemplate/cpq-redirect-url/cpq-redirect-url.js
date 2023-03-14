vlocity.cardframework.registerModule.controller('CPQRedirectController', ['$scope',
    function($scope) {
        $scope.init = function() {
            window.top.location.href = '/apex/%vlocity_namespace%__HybridCPQ?id='+ $scope.bpTree.response.records[0].id;
        }
    }
]);