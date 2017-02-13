# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# jQuery.ajax({
#   url: "/compare",
#   data: 'primary_id='+ primary_id + '&secondary_id='+secondary_id,
#   type: "POST",
#   success: function(result){
#     jQuery("#image_center").html("<%= escape_javascript(render(:partial => 'pages/top_link')) %>");
#   },
#   error: function(){
#     alert('Error occured');
#   }
# });
$(document).ready ->
  $("#new_article").on("ajax:success", (e, data, status, xhr) ->
    $("#results").html xhr.responseText
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#results").html "<p>ERROR</p>"

  $("#ships_form").on("ajax:success", (e, data, status, xhr) ->
    $("#ship_results").html xhr.responseText
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#ship_results").html "<p>ERROR</p>"
