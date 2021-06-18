vlocity.cardframework.registerModule.controller('googleColumnChartController', ['$scope', '$compile', '$filter', '$rootScope', function ($scope, $compile, $filter, $rootScope) {
    // Load the Visualization API and the corechart package.
    google.charts.load('current', { 'packages': ['corechart', 'gauge'] });
    var data;
    var chart;
    var options = {};
    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawChart);

    // Callback that creates and populates a data table,
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawChart() {

        // Create the data table.
        data = new google.visualization.DataTable();
        if($scope.obj){
            var chartData = $filter('getter')($scope.obj, $scope.data.fields[2]);
            data.addColumn(typeof($filter('getter')(chartData[0], $scope.data.fields[0])), $scope.data.fields[0].label);
            data.addColumn(typeof($filter('getter')(chartData[0], $scope.data.fields[1])), $scope.data.fields[1].label);
            for (var i = 0; i < chartData.length; i++) {
                data.addRow([$filter('getter')(chartData[i], $scope.data.fields[0]), $filter('getter')(chartData[i], $scope.data.fields[1])]);
            }
        }
        // Set chart options
        options = {
            'title': 'Column Chart',
            'width': 400,
            'height': 300
        }
        options.chartArea = { margin: 'auto' };

        //To set Chart Options
        function setOptions() {
            if ($scope.placeholder.Title && $scope.placeholder.Title.value) {
                options["title"] = $scope.placeholder.Title.value;
            }
            if ($scope.placeholder.Width && $scope.placeholder.Width.value) {
                options["width"] = $scope.placeholder.Width.value;
            }
            if ($scope.placeholder.Height && $scope.placeholder.Height.value) {
                options["height"] = $scope.placeholder.Height.value;
            }
        }

        setOptions();
        //To Draw Chart
        chart = new google.visualization.ColumnChart(document.getElementById('ColumnChart_div'));

        chart.draw(data, options);
    }
}]);