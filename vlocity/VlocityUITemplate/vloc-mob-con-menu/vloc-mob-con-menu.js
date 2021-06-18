vlocity.cardframework.registerModule
    .controller('SideMenuController',
                 ['$scope', '$timeout', '$rootScope', 'MobileService', 'AdminConfigService', 'appVersion', 'buildNumber','$ionicSideMenuDelegate', 
                 function($scope, $timeout, $rootScope, MobileService, AdminConfigService, appVersion, buildNumber, $ionicSideMenuDelegate) {
                     
    $scope.searchTerm = '';
    $scope.menus = $rootScope.menus;

    $scope.currentUser = $rootScope.currentUser;
    // $scope.myAvatar = MobileService.getImageFullUrl($scope.currentUser.Id, $scope.currentUser.SmallPhotoUrl);  
    $scope.myAvatar = $rootScope.customDefinedValue.CommunityURL + '/profilephoto/72936000000hGOT/T';
    
    $scope.devMode = AdminConfigService.isDevMode();
    $scope.appVersion = appVersion;
    $scope.buildNumber = buildNumber;
    $scope.selectedConfig = $rootScope.selectedConfig;
    
    // public functions
    $scope.openPage = function(menu) {
        MobileService.openPage(menu);
    }
        
    $scope.switchConfig = function () {
        MobileService.switchConfig();
    }
        
    $scope.showConfirm = function () {
        MobileService.logout();
    }

    $scope.searchAll = function () {
        MobileService.globalSearch(this.searchTerm);
    }

    $scope.clearCache = function () {
        MobileService.clearCache();
    }

    $scope.clearCacheAndReload = function() {
        MobileService.clearCacheAndReload();
    }    
    
    this.toggleSideMenu = function() {
        $ionicSideMenuDelegate.toggleLeft();
    }

}]);