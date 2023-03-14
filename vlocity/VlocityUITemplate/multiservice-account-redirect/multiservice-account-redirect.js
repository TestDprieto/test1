vlocity.cardframework.registerModule.controller('MultiServiceRedirectController', ['$scope',
    function($scope) {
        $scope.init = function() {
            window.top.location.href = '/'+ $scope.bpTree.response.AccountId;
        }
    }
]);