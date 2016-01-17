/* eslint-disable no-unused-vars */
/* global initMap */
/* global upVote */
/* global downVote */

// var drawerOpen = false;




var map;

function toggleDrawer() {
  $('#drawer-contents').toggle(50, "linear", function() {
    // drawerOpen = !drawerOpen;
    // if (drawerOpen === false) {
    //   document.getElementById('chevron').className = 'glyphicon glyphicon-chevron-down';
    // } else {
    //   document.getElementById('chevron').className = 'glyphicon glyphicon-chevron-up';
    // }
  });
}

$(document).ready(function() {

  $('.js-drawer-chevron').on("click", function() {
    toggleDrawer();
  });

  $('.pulse-button').on("click", function() {
    toggleDrawer();
  });

  $('.js-thumbs-up').on("click", function() {
    upVote();
  });

  $('.js-thumbs-down').on("click", function() {
    downVote();
  });
});