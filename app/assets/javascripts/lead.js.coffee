# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#lead_index tr").each ->
    url = $(this).data "lead-url"
    html = "<a href="+url+">"+$(this).find("td").html()+"</a>"
    $(this).find("td").html html

