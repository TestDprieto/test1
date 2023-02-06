vlocity.cardframework.registerModule.controller("billingController", [
  "$scope",
  function($scope) {
    $scope.summaryResult = [];
    $scope.detailResult = [];
    $scope.graphResult = [];
    $scope.chartTitles = [];
    $scope.topData = 0;
    $scope.chartColors = ["#ff2953","#7fbffc","#0081f9","#FCA33E","#60BD68","#bc5090", "#ffa600","#F47BB1","#B2912C","#4E4C4D"];

    // Returns a function, that, as long as it continues to be invoked, will not
    // be triggered. The function will be called after it stops being called for
    // N milliseconds. If `immediate` is passed, trigger the function on the
    // leading edge, instead of the trailing.
    function debounce(func, wait, immediate) {
    	var timeout;
    	return function() {
    		var context = this, args = arguments;
    		var later = function() {
    			timeout = null;
    			if (!immediate) func.apply(context, args);
    		};
    		var callNow = immediate && !timeout;
    		clearTimeout(timeout);
    		timeout = setTimeout(later, wait);
    		if (callNow) func.apply(context, args);
    	};
    }
    
    var showGraphFn = debounce(function() {
    	var conbillGraphEle = document.querySelector(".con-bill-graph");
          if (
            conbillGraphEle &&
            conbillGraphEle.getBoundingClientRect() !== null
          ) {
            if (
              conbillGraphEle.getBoundingClientRect().top <
              (window.innerHeight / 3) * 2
            ) {
              conbillGraphEle.classList.remove("con-bill-graph-small");
            } else {
              conbillGraphEle.classList.add("con-bill-graph-small");
            }
          }
    }, 250);

    function pageloaded() {
      //Page finished loading so show navbar
      showPage();
      //Scrolling graph animation
      var scrollContentContainers = document.querySelectorAll(
        ".scroll-content"
      );
      for (var i = 0; i < scrollContentContainers.length; i++) {
        scrollContentContainers[i].addEventListener("scroll", showGraphFn);
      }
    }

    function showPage() {
      if (document.querySelector(".con-navbar-app")) {
        var navbarApp = document.querySelector(".con-navbar-app");
        navbarApp.style.opacity = "1";
        document.querySelector(".con-bill").style.opacity = "1";
        setTimeout(function() {
          navbarApp.classList.add("con-loaded");
        }, 1000);
      } else {
        setTimeout(function() {
          showPage();
        }, 500);
      }
    }
    document.onload = pageloaded();

    this.init = function(payload) {
      if (payload && payload.result) {
        /* Summary Result */
        $scope.summaryResult = payload.result.summaryResult;

        /* Detail Result */
        var categoryBillingData = groupBy(payload.result.detailResult, function(
          item
        ) {
          return [item.%vlocity_namespace%__Type__c];
        });
        for (var i = 0; i < categoryBillingData.length; i++) {
          var _arr = removeDuplicates(
            categoryBillingData[i],
            "%vlocity_namespace%__ServiceName__c",
            true
          );
          categoryBillingData[i] = _arr;
        }
        $scope.detailResult = categoryBillingData;

        /* Graph Result */
        $scope.graphResult = groupBy(payload.result.graphResult, function(
          item
        ) {
          return [item.%vlocity_namespace%__ServiceEndDate__c];
        });
        sortChartData();
        $scope.topData = getMax(payload.result.graphResult, "expr0");
        $scope.chartTitles = removeDuplicates(
          payload.result.graphResult,
          "%vlocity_namespace%__Type__c",
          false
        );
      }
    };

    function groupBy(array, f) {
      var groups = {};
      array.forEach(function(o) {
        var group = JSON.stringify(f(o));
        groups[group] = groups[group] || [];
        groups[group].push(o);
      });
      return Object.keys(groups).map(function(group) {
        return groups[group];
      });
    }

    function sortChartData() {
      for (var i = 0; i < $scope.graphResult.length; i++) {
        $scope.graphResult[i].sort(function(a, b) {
          if (a.%vlocity_namespace%__Type__c < b.%vlocity_namespace%__Type__c) return -1;
          if (a.%vlocity_namespace%__Type__c > b.%vlocity_namespace%__Type__c) return 1;
          return 0;
        });
      }
    }

    function removeDuplicates(arr, prop, addCurrency) {
      var obj = {};
      for (var i = 0, len = arr.length; i < len; i++) {
        if (!obj[arr[i][prop]]) {
          obj[arr[i][prop]] = arr[i];
        } else if (addCurrency) {
          obj[arr[i][prop]].%vlocity_namespace%__CurrencyAmount__c +=
            arr[i].%vlocity_namespace%__CurrencyAmount__c;
        }
      }
      var newArr = [];
      for (var key in obj) newArr.push(obj[key]);
      return newArr;
    }

    function getMax(arr, prop) {
      var max = 0;
      arr.forEach(function(data) {
        if (max < data[prop]) {
          max = data[prop];
        }
      });
      return max;
    }

    $scope.getStatementStartDate = function(date) {
      var d = new Date(date);
      d.setMonth(d.getMonth() - 1);
      return moment(d).format("MMM DD");
    };
    $scope.getStatementEndDate = function(date) {
      var d = new Date(date);
      d.setDate(d.getDate() - 1);
      return moment(d).format("MMM DD");
    };
  }
]);