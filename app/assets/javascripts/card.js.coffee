window.DH.Card = {}

window.DH.Card.ObserveCardContenteditableSave = class OpenCardInDialog
  constructor: (selector) ->
    this.add_listener()

  add_listener: () ->
    $(document).on 'click', '.update-editable-html', ->
      console.log 'A'
      html_to_save = $('#cardtec_card_html')
      if html_to_save
        path = $('*[data-card-path]:first').data('card-path') || window.location.pathname
        $.ajax
          url:  path
          data: { cardtec_node: { html: html_to_save.html() } }
          type: 'PUT'
          dataType: 'script'


    $(document).on 'click', '.create-editable-html', ->
      html_to_save = $('#cardtec_card_html')
      path_elements = window.location.pathname.split('/')
      path_elements.pop()
      path = $('*[data-card-path]:first').data('card-path') || path_elements.join('/')
      if html_to_save && path
        $.ajax path,
          data: { cardtec_node: { html: html_to_save.html() } }
          type: 'POST'
          dataType: 'script'


    $(document).on 'click', '.add-editable-html', (event)->
      current_property = $(this).closest('.cardtec_property')
      new_property = current_property.clone()
      $('.cardtec_property_name', new_property).html('')
      $('.cardtec_property_value', new_property).html('')
      current_property.after(new_property)

    $(document).on 'click', '.remove-editable-html', ->
      $(this).closest('.cardtec_property').remove()


    add_button = () ->
      $('<button>').attr(class: 'button radius add-editable-html').append(
        $('<i>').attr(class: 'fa fa-plus-circle')
      )

    remove_button = () ->
      $('<button>').attr(class: 'button radius remove-editable-html').append(
        $('<i>').attr(class: 'fa fa-minus-circle')
      )

    button_wrapper = () ->
      $('<div>').attr(class: 'cardtec_property_actions')

    property_buttons = () ->
      button_wrapper().append(add_button()).append(remove_button())

    $(document).ready ->
      properties = $('#cardtec_card_html .cardtec_property')
      properties.append(property_buttons)



# observe_card_contenteditable_save()


# $('.card.card_maker_concept a').attr('data-reveal-id', 'operations_dialog').attr('data-reveal-ajax','true')


# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



# load_content_in_element = (element, url) ->
#   $(element).load url, (response, status) ->
#     $(element).addClass('alert-box alert') if status == 'error'




# initial_load_contents = () ->
#   for element in $('*[data-initial-remote-url]')
#     load_content_in_element($(element), $(element).data('initial-remote-url'))


# observe_load_content_clicks = () ->
#   $(document).on 'click touchend', '*[data-destination-element]', ->
#     destination_element = $('.' + $(this).data('destination-element'))
#     if destination_element && (destination_url = $(this).data('destination-url'))
#       load_content_in_element(destination_element, destination_url)


# window.load_contents = initial_load_contents


# initial_load_contents()
# observe_load_content_clicks()