# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:ready page:change', ->
  $('textarea#eg-textarea').editable({
    inlineMode: false
  })

  $('.expand-btn').click ->
    $plist = $(this).parent().find('.expandable')
    if $plist.css('display') == 'none'
      $plist.slideDown()
    else
      $plist.slideUp()