# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$(document).ready ->
  if controller_name == "project/tickets" and action_name == "new"
    $("#new-ticket-subnav-li").addClass "active"
  else if controller_name == "projects"
    $("#project-subnav-li").addClass "active"
  else if controller_name == "project/tickets"
    $("#tickets-subnav-li").addClass "active"

