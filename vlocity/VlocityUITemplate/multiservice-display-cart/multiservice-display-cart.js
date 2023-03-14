vlocity.cardframework.registerModule.controller('DisplayCPQController', ['$scope',
    function($scope) {

        $scope.isToShow = false;

        $scope.nsp = $scope.bpService.sNS + '__';

        $scope.multiServiceCPQbaseURL = 'apex/'+ $scope.nsp + 'MultiServiceCPQRedirect';

        $scope.hybridCPQbaseURL = 'apex/'+ $scope.nsp + 'HybridCPQ';

        var selectedWrapperId, randomCount = 1;

        var cartURL;

        $scope.getURL = function() {
            $scope.isToShow = false;
            var cartStrategy = $scope.bpTree.response.cartStrategy;
            if(cartStrategy === 'select') {
                cartStrategy = $scope.bpTree.response.selectedCartStrategy;
            }
            if(!$scope.bpTree.wrapperCart || !$scope.bpTree.wrapperCart.Id) {
                return '';
            }

            if(selectedWrapperId && $scope.bpTree.wrapperCart.Id === selectedWrapperId && randomCount === $scope.bpTree.randomCount) {
                $scope.isToShow = true;
                return cartURL;
            }
            if(cartStrategy === 'single') {
                cartURL = getHybridCPQURL();
            } else if(cartStrategy === 'multiple') {
                cartURL = getMultiServiceCPQURL();
            }
            selectedWrapperId = $scope.bpTree.wrapperCart.Id;
            $scope.isToShow = true;
            return cartURL;
        }

        function getHybridCPQURL() {

            var groupPageSize = $scope.bpTree.response.groupPageSize;
            if(!groupPageSize) {
                groupPageSize = 20;
            }
            var memberPageSize = $scope.bpTree.response.memberPageSize;
            if(!memberPageSize) {
                memberPageSize = 20;
            }

            var parameters = [];
            parameters.push('id=' + $scope.bpTree.wrapperCart.Id);
            parameters.push('groupPageSize=' + groupPageSize);
            parameters.push('memberPageSize=' + memberPageSize);

            var url = $scope.hybridCPQbaseURL + '?' + parameters.join('&');

            return url;
        }
        function getMultiServiceCPQURL() {
            
            if(!$scope.bpTree.response.cartType) {
                return undefined;
            }
            var groupPageSize = $scope.bpTree.response.groupPageSize;
            if(!groupPageSize) {
                groupPageSize = 20;
            }
            var memberPageSize = $scope.bpTree.response.memberPageSize;
            if(!memberPageSize) {
                memberPageSize = 20;
            }
            var parameters = [];
            if($scope.bpTree.randomCount) {
                randomCount = $scope.bpTree.randomCount;
                parameters.push('dummy=' + Math.floor(Math.random() * 100) + 1);
            }
            
            parameters.push('contextId=' + $scope.bpTree.wrapperCart.Id);
            parameters.push('parentId='+ $scope.bpTree.ContextId);
            parameters.push('redirectToFirstGroup=true');
            parameters.push('groupPageSize=' + groupPageSize);
            parameters.push('memberPageSize=' + memberPageSize);
            parameters.push('cartType='+ $scope.bpTree.response.cartType);

            var url = $scope.multiServiceCPQbaseURL + '?' + parameters.join('&');

            return url;
        }
    }
]);