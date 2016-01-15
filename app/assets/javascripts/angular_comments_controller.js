/* global angular */
(function() {
  "use strict";
  angular.module("app").controller("comments", function($scope, $http) {

    $scope.setup = function() {
      $http.get('/api/v1/comments.json').then(function(response) {
        $scope.comments = response.data;
        $scope.commentsShownCount = 5;
      });
    };

    $scope.submitComment = function(inputCommentBody, inputResourceId, inputUserId) {
      $http.post('/api/v1/comments.json', {
        inputCommentBody: inputCommentBody,
        inputResourceId: inputResourceId,
        inputUserId: inputUserId
      }).then(function(response) {
        $scope.comments.unshift(response.data);
      });
      $scope.newCommentBody = null;
      $('#comment-submit').blur();
    };

    $scope.upvote = function(inputComment) {
      $scope.comment = inputComment;
      $http.post('/comment_ratings', {
        commentId: inputComment.id,
        ratingValue: 1
      }).then(function(response) {
        if (response.data.exists === false) {
          $scope.comment.score += 1;
        }
      });
    };

    $scope.downvote = function(inputComment) {
      $scope.comment = inputComment;
      $http.post('/comment_ratings', {
        commentId: inputComment.id,
        ratingValue: -1
      }).then(function(response) {
        if (response.data.exists === false) {
          $scope.comment.score -= 1;
        }
      });
    };

    $scope.deleteComment = function(comment) {
      $http.delete('/api/v1/comments/' + comment.id);
      var index = $scope.comments.indexOf(comment);
      $scope.comments.splice(index, 1);
    };

    $scope.showAllComments = function() {
      $scope.commentsShownCount = 999999;
    };

    window.$scope = $scope;
  });
})();