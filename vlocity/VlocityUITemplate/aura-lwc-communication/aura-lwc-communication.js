vlocity.cardframework.registerModule.controller('auraLwcController', ['$scope','$timeout', function($scope, $timeout) {
    $scope.filterLwcList = function(event){
        $scope.performLwcAction('vlocityLwcEvent','filterList',{
                    'key' : $scope.searchTerm.value
                });
    }

    $scope.$on('reloadPage',function(){
        window.location.reload();
    })
}]);