/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("comments", function($scope, $http) {
    
    $scope.setup = function() {
      // var $scope.resourceComments = [];
      $http.get('/api/v1/comments.json').then(function(response) {
        $scope.comments = response.data;
      });
    };

    $scope.submitComment = function(inputCommentBody, inputResourceId, inputUserId) {
      $http.post('/api/v1/comments.json', {
        inputCommentBody: inputCommentBody,
        inputResourceId: inputResourceId,
        inputUserId: inputUserId
      }).then(function(response) {
        $scope.comments.push(response.data);
      });
      console.log("hello");
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