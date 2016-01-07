/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("resources", function($scope, $http) {

    $scope.setup = function() {
      $http.get('/api/v1/resources.json').then(function(response) {
        $scope.resources = response.data;
        $scope.unverifiedCount = 0;
      });
    };

    $scope.deleteResource = function(inputResource) {
      var resourceIndex = $scope.resources.indexOf(inputResource);
      var id = inputResource.id;
      $http.delete('/api/v1/resources/' + id);
      $scope.resources.splice(resourceIndex, 1);
    };

    $scope.verifyResource = function(inputResource) {
      var resourceIndex = $scope.resources.indexOf(inputResource);
      var id = inputResource.id;
      $http.patch('/api/v1/resources/' + id, {
        status: "verified"
      });
      $scope.resources.splice(resourceIndex, 1);
    };

    $scope.isVerified = function(inputResource) {
      if (inputResource.status === "unverified") {
        $scope.unverifiedCount = 1;
        return true;
      }
    };

    $scope.javascriptSucks = function(inputSearchString) {
      $http.get('/api/v1/resources.json?search=' + inputSearchString).then(function(response) {
        $scope.searchResults = response.data;
      });
    };

    window.$scope = $scope;
  });
})();