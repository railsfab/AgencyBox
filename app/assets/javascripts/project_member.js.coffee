# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".user").click ->
  $(this).toggleClass("selected")

$("#arrow-box img").click ->
  $selected = $("."+$(this).data('frm')+" .user.selected")
  if $selected.filter("[old='yes']").length > 0
    alert "You can only add members here, cannot delete the already existing members from here."
  $selected = $selected.not("[old='yes']")
  html = ""
  $selected.each ->
    html += "<div class='user' uid='"+$(this).attr('uid')+"'>"+this.textContent+"</div>"
  $("."+$(this).data('to')+" .box-content").append html
  $(".user").off()
  $(".user").click ->
    $(this).toggleClass("selected")
  $selected.remove()

$("#submit-btn").click ->
  users = $(".to-box .user").map ->
    $(this).attr "uid"
  $("[name='users']").val users.toArray().join "-"
  $("#add-members").submit()
