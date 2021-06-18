vlocity.cardframework.registerModule
.controller('listCardCanvasSldsController',
            ['$scope','force', '$rootScope', '$filter', function($scope, force, $rootScope, $filter) {
    $scope.cardIcon = null;
    $scope.setCardIcon = function(){
        if($scope.session.objType) {
            $scope.cardIcon = $rootScope.cardIconFactory($scope.session.objType);
        }
    };
    $scope.setCardIcon();
}]);