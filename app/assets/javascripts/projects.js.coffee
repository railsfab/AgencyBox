# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$(document).ready ->
  if controller_name == "tickets" and action_name == "new"
    $("#new-ticket-subnav-li").addClass "active"
  if controller_name == "tickets" and action_name == "tickets"
    $("#tickets-subnav-li").addClass "active"
  if controller_name == "projects" and action_name == "show"
    $("#project-subnav-li").addClass "active"

