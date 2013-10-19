# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$("#submit-filter").click ->
  if $(".filter-box input[type='radio']:checked").length > 0
    pathname = "#{window.location.pathname}?"
  else
    pathname = window.location.pathname
  
  if $("#amount-filter-box input[type='radio']:checked").length > 0
    pathname += "amount_filter=#{$("#amount-filter-box input[type='radio']:checked").val()}&"
  if $("#status-filter-box input[type='radio']:checked").length > 0
    status = $("#status-filter-box input[type='radio']:checked").val()
    if status != "none"
      pathname += "status=#{status}&"
  pathname = pathname.replace(/&$/, "")
  window.location = pathname


$(document).ready ->
  search = location.search.replace(/^\?/, "").split("&")
  search_params = {}
  for val in search
    search_arr = val.split "="
    search_params[search_arr[0]] = search_arr[1]
  search_params_keys = Object.keys(search_params)
  if "amount_filter" in search_params_keys
    $("#amount-filter-box input[type='radio'][value='"+search_params['amount_filter']+"']").prop("checked", true)
  if "status" in search_params_keys
    $("#status-filter-box input[type='radio'][value='"+search_params['status']+"']").prop("checked", true)
  

  
