/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("resources", function($scope, $http) {

    $scope.setup = function() {
      $http.get('/api/v1/resources.json').then(function(response) {
        $scope.resources = response.data;

        for (var i = 0; i < $scope.resources.length; ++i) {
          $scope.resources[i].latitudeDifference = $scope.resources[i].latitude - lat;
          $scope.unverifiedCount++;
        }

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

    $scope.unsureResource = function(inputResource) {
      var resourceId = inputResource.id;
      var rating = 0;
      $http.post('/api/v1/resource_ratings', {
        id: resourceId,
        rating: rating
      }).then(function(response) {
        console.log(response.data);
      });
    };

    $scope.isUnverified = function(inputResource) {
      if (inputResource.status === "unverified") {
        return true;
      }
    };

    $scope.searchFor = function(inputSearchString) {
      if ($scope.searchString.length > 0) {
        $http.get('/api/v1/resources.json?search=' + inputSearchString).then(function(response) {
          $scope.searchResults = response.data;
          $scope.resultsShown = 5;
        });
      } else {
        $scope.resultsShown = 0;
      }
    };

    $scope.searchSelect = function(inputSearchedResource) {
      window.location = '/resources/' + inputSearchedResource.id;
    };


    window.$scope = $scope;
  });
})();