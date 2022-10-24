vlocity.cardframework.registerModule.controller('containerTableCanvarController', ['$rootScope', '$scope', '$filter','$timeout', function($rootScope, $scope, $filter,$timeout) {

    // Set this to get the Card changes with datasouce interval timer
    $rootScope.emitCardChanges = true;

    //Decides the sorting order
    $scope.sortingOrder = '';
    //Determines sorting should be ascending or descending
    $scope.reverse = false;
    //List holds the filtered items
    $scope.filteredItems = [];
    //Items after dividing for different pages
    $scope.pagedItems = [];
    //Determines item per page
    $scope.itemsPerPage = 5;
    //Current selected page
    $scope.currentPage = 0;
    //List includes items per page options
    $scope.numberOfRowsOption = [5, 10, 20];
    //number of items per page
    $scope.numberOfPageLinks = 3;
    //need to re-render cards on update
    $scope.render = true;

    //Adjustable Column width
    var pressed = false;       // To check whether table header is pressed
    var start = undefined;     // To get the selected table header
    var startX, startWidth;    // To set the width of Table Column 
    var scroll = false;        // To check whether table header is dragged
    var drag = false;          // To prevent table sort

    //To fire event on hover of Table Header Border
    $('table').on('mousemove', 'th', function (e) {
        if (!pressed) {
            var offset = $(this).offset();
            var left = offset.left + $(this).width();
            if (left - e.pageX < 10) {
                $(this).addClass("resizing");
                $(this).css("border-right", "2px solid #07abdc");
                scroll = true;
                event.stopPropagation();
            } else {
                pressed = false;
                scroll = false;
                $(this).removeClass("resizing");
                $('th').css("border-right", "2px solid #f9f9f9");
            }
        }
    });

    //To fire event on click of Table Header
    $('table').on('mousedown', 'th', function (e) {
        if (scroll) {
            start = $(this);
            startX = e.pageX;
            pressed = true;
            startWidth = $(this).width();
            $(this).css("border-right", "2px solid #07abdc");
        } else {
            $('th').css("border-right", "2px solid #f9f9f9");
        }
    });


    //To fire event on drag of Table Header
    $(document).mousemove(function (e) {
        if (pressed) {
            drag = true;
            $(start).width(startWidth + (e.pageX - startX));
            $(start).addClass("resizing");
            event.stopPropagation();
            var offset = $(start).offset();
            var left = offset.left;
            if(($(start).width() + left) >= ($('#table-div').width() - 50) ){
                var right = $('#table-div').width() - 50 - left;
                $(start).width(right);
            }
            else if ($(start).width() < 100) {
                $(start).width(100)
            }
            scroll = false;
            $('th').css("border-right", "2px solid #f9f9f9");
        }
    });

    //To end the event fired on drag of Table Header
    $(document).mouseup(function () {
        if (pressed) {
            pressed = false;
            setTimeout(function () { drag = false }, 50);
            $(start).removeClass("resizing");
            $(start).css("border-right", "2px solid #f9f9f9");
            event.stopPropagation();
        }
    });

    //INIT rows
     //Need this watch for the first load to initialize vlocCard as the below event is not recieved.
     var unbind = $scope.$watch('cards.length', function(length) {
        $scope.items = $scope.cards;
        $scope.search();
        unbind();
    });

    // Need this event to update Layout on record data update.
    $rootScope.$on('vlocity.CardChanges', function(event, data) {
        $scope.render = false;
        $scope.items = $scope.cards;
        $scope.search();
        $timeout(function(){ $scope.render = true; }, 0);
    });

    //init the filtered items / if no search query is mentioned then
    $scope.search = function () {
        $scope.filteredItems = $filter('filter')($scope.items, filterTable);
        $scope.groupToPages();
    };

    //Filter function 
    var filterTable = function(row) {
        var rawData = row.obj;
        var isFound = true;
        if ($scope.searchTerm) {
            var getterFilter = $filter('getter');
            _.some(row.states[0].fields, function (field) {
                var fieldValue = (getterFilter(rawData, field)+"").toUpperCase();
                isFound = _.includes(fieldValue, $scope.searchTerm.toUpperCase());
                return isFound;
            });
        }
        return isFound;
    }

    //To divide cards object in different pages.
    $scope.groupToPages = function () {
        $scope.pagedItems = [];

        //Maintain sort order
        if ($scope.sortingOrder !== '') {
            $scope.filteredItems = $filter('orderBy')($scope.filteredItems, $scope.sortingOrder, $scope.reverse);
        }

        for (var i = 0; i < $scope.filteredItems.length; i++) {
            if (i % $scope.itemsPerPage === 0) {
                $scope.pagedItems[Math.floor(i / $scope.itemsPerPage)] = [ $scope.filteredItems[i] ];
            } else {
                $scope.pagedItems[Math.floor(i / $scope.itemsPerPage)].push($scope.filteredItems[i]);
            }
        }


        $scope.currentPage = 0;
        $scope.previousPage = 0;
        $scope.nextPage = $scope.currentPage + 1;
    };

    //To create pagination links
    $scope.range = function (size, start, numberOfPages) {
        var ret = [];
        var end = start + numberOfPages;

        if (size < end) {
            end = size;
            start = size - $scope.numberOfPageLinks;
            if (start < 0) {
                start = 0;
            }
        }
        for (var i = start; i < end; i++) {
            ret.push(i);
        }

        return ret;
    };

    //To visit a particular page
    $scope.goToPage = function(pageNumber) {
        $scope.currentPage = pageNumber;
        $scope.previousPage = pageNumber - 1;
        $scope.nextPage = pageNumber + 1;
    }

    // change sorting order
    $scope.sortBy = function (newSortingOrder) {
        if (!drag) {
            $('th').css("border-right", "2px solid #f9f9f9");
            $scope.reverse = !$scope.reverse;
            $scope.sortingOrder = 'obj' + newSortingOrder.name;
            $scope.filteredItems = $filter('orderBy')($scope.filteredItems, $scope.sortingOrder, $scope.reverse);
            $scope.groupToPages();
        }
    };

    //watch for change in number of items inside a page
    $scope.$watch('itemsPerPage', function(length) {
        $scope.search();
    });

    $scope.getCardList = function () {
        // This needs to be set to support datasouce interval timer on all of these pages.
        $rootScope.reloadRecords = true;
        return $scope.pagedItems[$scope.currentPage];
    }

}]);