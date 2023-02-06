vlocity.cardframework.registerModule.controller('CPQRedirectController', ['$scope',
    function($scope) {
        $scope.init = function() {
            window.top.location.href = '/'+ $scope.bpTree.response.AccountId;
        }
    }
]);