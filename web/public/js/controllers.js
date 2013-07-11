function UrlListCtrl($scope, $http) {
  $http.get('../../data/sites.json').success(function(data) {
    $scope.sites = data;
    // get file from hard disk
    // add it to scope as a parameter
  });

  // $scope.orderProp = 'age';
}