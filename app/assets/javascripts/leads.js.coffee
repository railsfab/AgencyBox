# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  search = window.location.search.replace(/^\?/, '').split("=")
  if search
    if search[0] == "only_converted" and search[1] == "true"
      $("#show-converted-leads").prop("checked", search[1])

  

  $("#lead_index tr").each ->
    url = $(this).data "lead-url"
    $(this).find("td").each ->
      html = "<a href="+url+">"+$(this).html()+"</a>"
      $(this).html html

  $("#lead_index table").tablesorter()

  $("#convert-lead").click ->
    leads = $(".cb-lead:checked").map ->
      $(@).attr "lid"
    .get()
    if not leads.length
      return
    $(".checked-leads").val leads.join(",")
    $("form#convert-lead-form").submit()


$("#show-converted-leads").change ->
  q = ""
  if $(this).prop("checked")
    q = "only_converted=true"
  url = window.location.pathname
  if q
    url += "?#{q}"
  window.location = url
