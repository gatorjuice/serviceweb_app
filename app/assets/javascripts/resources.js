/* eslint-disable no-unused-vars */

var drawerOpen = false;

function toggleDrawer() {
  $('#drawer-contents').toggle(200, "linear", function() {
    drawerOpen = !drawerOpen;
    if (drawerOpen === false) {
      document.getElementById('chevron').className = 'glyphicon glyphicon-chevron-down';
    } else {
      document.getElementById('chevron').className = 'glyphicon glyphicon-chevron-up';
    }
  });
}

$(document).ready(function() {
  $('#drawer-contents').hide();
});