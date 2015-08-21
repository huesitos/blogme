# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:ready page:change', ->
  $('textarea#eg-textarea').editable({
    inlineMode: false
  })

  $('.expand-btn').click ->
    $plist = $(this).parent().find('.monthly-posts')
    console.log($plist)
    for post in $plist.children('li')
      do ->
        $(post).toggleClass('show')
        $(post).toggleClass('hidden')
