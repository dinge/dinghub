# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


load_content_in_element = (element, url) ->
  $(element).load url, (response, status) ->
    $(element).addClass('alert-box alert') if status == 'error'




initial_load_contents = () ->
  for element in $('*[data-initial-remote-url]')
    load_content_in_element($(element), $(element).data('initial-remote-url'))


observe_load_content_clicks = () ->
  $(document).on 'click touchend', '*[data-destination-element]', ->
    destination_element = $('.' + $(this).data('destination-element'))
    if destination_element && (destination_url = $(this).data('destination-url'))
      load_content_in_element(destination_element, destination_url)


# window.load_contents = initial_load_contents


initial_load_contents()
# observe_load_content_clicks()