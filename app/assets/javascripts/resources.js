/* eslint-disable no-unused-vars */
var drawerOpen = false;
var map;
var lat;
var lng;


function checkComments() {
  console.log("hello");
}

function upVote() {
  console.log("upvote");

}

function downVote() {
  console.log("downvote");
}

function showPosition(position) {
  lat = position.coords.latitude;
  lng = position.coords.longitude;
  var location = "lat: " + position.coords.latitude + ", lng: " + position.coords.longitude;
  initMap(lat, lng);
}

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    x.innerHTML = "Geolocation is not supported by this browser.";
  }
}

function toggleDrawer() {
  $('#drawer-contents').toggle(50, "linear", function() {
    drawerOpen = !drawerOpen;
    if (drawerOpen === false) {
      document.getElementById('chevron').className = 'glyphicon glyphicon-chevron-down';
    } else {
      document.getElementById('chevron').className = 'glyphicon glyphicon-chevron-up';
    }
  });
}

$(document).ready(function() {
  getLocation();
  $('.js-drawer-chevron').on("click", function() {
    toggleDrawer();
  });

  $('.js-thumbs-up').on("click", function() {
    upVote();
  });

  $('.js-thumbs-down').on("click", function() {
    downVote();
  });
});