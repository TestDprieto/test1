vlocity.cardframework.registerModule.controller('trackFieldController', ['$scope', '$filter', function($scope,$filter) {
        
        $scope.isString = function(value){
             if(value.type==="string"){
                return true;
            }else if(value.type==="object"){
                return false;
            }
        }
        $scope.getIconSet = function(object){
            if(!$scope.isJsonString(object)) {
                object = eval(object);
            }
            object = JSON.parse(object);
            $scope.sprite = object.sprite;
            $scope.icon = object.icon;
        }
        
        $scope.isJsonString =function(str) {
            try {
                JSON.parse(str);
            } catch (e) {
                return false;
            }
            return true;
        }
}]);