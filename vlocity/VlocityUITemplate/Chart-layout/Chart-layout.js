vlocity.cardframework.registerModule.controller('ChartController', ['$scope', function ($scope) {
  // Your code goes here
  var chartScript;
  if (!document.getElementById('google-chart')) {
    chartScript = document.createElement("script");
    chartScript.type = "text/javascript";
    chartScript.src = "https://www.gstatic.com/charts/loader.js";
    chartScript.id = "google-chart"
    $("body").append(chartScript);
  }
}]);