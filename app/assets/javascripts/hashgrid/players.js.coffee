# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


load_content_in_element = (element, url) ->
  $(element).load url, (response, status) ->
    $(element).addClass('alert-box alert') if status == 'error'




initial_load_contents = () ->
  for element in $('*[data-remote-url]')
    load_content_in_element($(element), $(element).data('remote-url'))


observe_load_content_clicks = () ->
  $(document).on 'click touchstart', '*[data-remote-url]', ->
    remote_url = $(this).data('remote-url')
    destination_element = $('.' + $(this).data('destination-element'))
    if remote_url && destination_element
      load_content_in_element(destination_element, remote_url)



initial_load_contents()
observe_load_content_clicks()