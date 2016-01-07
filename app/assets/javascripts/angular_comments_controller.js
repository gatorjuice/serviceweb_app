/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("comments", function($scope, $http) {
    
    $scope.setup = function() {
      $http.get('/api/v1/comments.json').then(function(response) {
        $scope.comments = response.data;
      });
    };

    $scope.upvote = function(inputComment) {
      $scope.comment = inputComment;
      $scope.comment.score += 1;
    };

    $scope.downvote = function(inputComment) {
      $scope.comment = inputComment;
      $scope.comment.score -= 1;
    };

    window.$scope = $scope;
  });
})();