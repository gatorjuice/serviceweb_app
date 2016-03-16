/* global angular */
/* global initMap */


(function() {
  "use strict";
  angular.module("app").controller("resources", ["$scope", "$http", "$q", function($scope, $http, $q) {


    var opts = {
      lines: 13, // The number of lines to draw
      length: 28, // The length of each line
      width: 14, // The line thickness
      radius: 42, // The radius of the inner circle
      scale: 1, // Scales overall size of the spinner
      corners: 1, // Corner roundness (0..1)
      color: '#000', // #rgb or #rrggbb or array of colors
      opacity: 0.25, // Opacity of the lines
      rotate: 0, // The rotation offset
      direction: 1, // 1: clockwise, -1: counterclockwise
      speed: 1, // Rounds per second
      trail: 60, // Afterglow percentage
      fps: 20, // Frames per second when using setTimeout() as a fallback for CSS
      zIndex: 2e9, // The z-index (defaults to 2000000000)
      className: 'spinner', // The CSS class to assign to the spinner
      top: '50%', // Top position relative to parent
      left: '50%', // Left position relative to parent
      shadow: false, // Whether to render a shadow
      hwaccel: false, // Whether to use hardware acceleration
      position: 'absolute' // Element positioning
    };
    var target = document.getElementById('home-panel');
    var spinner = new Spinner(opts).spin(target);


    var lat;
    var lng;


    var deferred = $q.defer();


    $scope.setup = function() {
      getLocation();
      $http.get('/api/v1/resources.json').then(function(response) {
        $scope.unverifiedResources = response.data;
      });

      $scope.panelText = "The closest food, health, and shelter resources are loading. Please wait.";

      deferred.promise.then(function() {
        spinner.stop();

        $http.get('/api/v1/closest_food_resource?lat=' + lat + '&lng=' + lng).then(function(response) {
          $scope.closestFoodResource = response.data;
        });

        $http.get('/api/v1/closest_health_resource?lat=' + lat + '&lng=' + lng).then(function(response) {
          $scope.closestHealthResource = response.data;
        });

        $http.get('/api/v1/closest_shelter_resource?lat=' + lat + '&lng=' + lng).then(function(response) {
          $scope.closestShelterResource = response.data;
        }).then(function() {
          sendLatAndLng();
          $scope.panelText = "Select the resource that meets their needs and enter the person's phone number on the next page that loads. Your number and personal information will not be texted along with the resource.";
          $scope.formatPhoneNumber = function(inputNumber) {
            var firstThree = inputNumber.substring(0,3);
            var middleThree = inputNumber.substring(3,6);
            var lastFour = inputNumber.substring(6,10);
            return "(" + firstThree + ")" + " " + middleThree + "-" + lastFour;
          };
        });
      });
    };

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  }
}

function sendLatAndLng() {
  $http.post("/position", {
    latitude: lat,
    longitude: lng
  }).then(function(response) {
    console.log(response.data);
  });
}


function showPosition(position) {
  lat = position.coords.latitude;
  lng = position.coords.longitude;
  initMap(lat, lng);
  $scope.lat = lat;
  $scope.lng = lng;
  deferred.resolve();
}




$scope.deleteResource = function(inputResource) {
  var resourceIndex = $scope.unverifiedResources.indexOf(inputResource);
  var id = inputResource.id;
  var rating = -1;
  $http.post('/api/v1/resource_ratings', {
    id: id,
    rating: rating
  }).then(function() {
    $scope.unverifiedResources.splice(resourceIndex, 1);
  });
};

$scope.verifyResource = function(inputResource) {
  var resourceIndex = $scope.unverifiedResources.indexOf(inputResource);
  var id = inputResource.id;
  var rating = 1;
  $http.post('/api/v1/resource_ratings', {
    id: id,
    rating: rating
  }).then(function() {
    $scope.unverifiedResources.splice(resourceIndex, 1);
  });
};

$scope.unsureResource = function(inputResource) {
  var resourceIndex = $scope.unverifiedResources.indexOf(inputResource);
  var id = inputResource.id;
  var rating = 0;
  $http.post('/api/v1/resource_ratings', {
    id: id,
    rating: rating
  }).then(function() {
    $scope.unverifiedResources.splice(resourceIndex, 1);
  });
};

$scope.showHelp = function(inputVote) {
  if (inputVote === 'upvote') {
    console.log("you know of this resource and agree with it's legitimacy.");
  } else if (inputVote === 'downvote') {
    console.log("you believe this reource to be spam or not correctly identified.");
  } else {
    console.log("you are unsure of this resource but do not doubt it's legitimacy.");
  }
};

$scope.unverifiedResourcesExist = function() {
  if ($scope.unverifiedResources === undefined) {
    return true;
  } else {
    return $scope.unverifiedResources.length > 0;
  }
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
      $scope.searchResults.first.focus();
    });
  } else {
    $scope.resultsShown = 0;
  }
};

$scope.searchSelect = function(inputSearchedResource) {
  window.location = '/resources/' + inputSearchedResource.id;
};

$scope.hideDrawer = function() {
  if ($scope.unverifiedResources.lenth < 1) {
    $('#alert-button').hide();
  }
};

$scope.getLeaderboard = function() {
  $http.get('/api/v1/leaderboard').then(function(response) {
    $scope.leaderboard = response.data;
  });
};


window.$scope = $scope;
}]);
})();