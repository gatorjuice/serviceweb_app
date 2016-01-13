/* global angular */
/* global initMap */

(function() {
  "use strict";
  angular.module("app").controller("resources", function($scope, $http, $q) {

    var lat;
    var lng;

    var deferred = $q.defer();
    
    $scope.setup = function() {
      $http.get('/api/v1/resources.json').then(function(response) {
        $scope.resources = response.data;
      });

      getLocation();

      deferred.promise.then(function() {

        $http.get('/api/v1/closest_food_resource?lat=' + lat + '&lng=' + lng).then(function(response) {
          $scope.closestFoodResource = response.data.resource;
        });

        $http.get('/api/v1/closest_health_resource?lat=' + lat + '&lng=' + lng).then(function(response) {
          $scope.closestHealthResource = response.data.resource;
        });

        $http.get('/api/v1/closest_shelter_resource?lat=' + lat + '&lng=' + lng).then(function(response) {
          $scope.closestShelterResource = response.data.resource;
        });
      });
    };

    function getLocation() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
      }
    }

    function showPosition(position) {
      lat = position.coords.latitude;
      lng = position.coords.longitude;
      initMap(lat, lng);
      deferred.resolve();
    }

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