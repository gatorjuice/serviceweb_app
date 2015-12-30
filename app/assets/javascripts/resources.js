/* eslint-disable no-unused-vars */

var drawerOpen = false;

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

function showInfo() {
  console.log('you are hovering over the mouse');
}

$(document).ready(function() {
  $('#drawer-contents').hide();
});