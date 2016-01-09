/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("comments", function($scope, $http) {
    
    $scope.setup = function() {
      // var $scope.resourceComments = [];
      $http.get('/api/v1/comments.json').then(function(response) {
        $scope.comments = response.data;
        // for (var i = 0; i < $scope.comments.length; i++) { 
        //   if ($scope.comments[i].resource_id === 4) {
        //     $scope.resourceComments.push($scope.comments[i]);
        //   } 
        // }
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