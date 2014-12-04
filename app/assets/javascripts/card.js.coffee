observe_card_contenteditable_save = () ->
  $(document).on 'click touchend', '.update-editable-html', ->
    html_to_save = $('#cardtec_card_html')
    if html_to_save
      path         = window.location.pathname
      $.ajax
        url:  path + '.js'
        data: { cardtec_node: { html: html_to_save.html() } }
        type: 'PUT'


  $(document).on 'click touchend', '.create-editable-html', ->
    html_to_save = $('#cardtec_card_html')
    path_elements = window.location.pathname.split('/')
    path_elements.pop()
    path = path_elements.join('/')
    path += '.js'
    if html_to_save && path
      $.ajax path,
        data: { cardtec_node: { html: html_to_save.html() } }
        type: 'POST'


  $(document).on 'click touchend', '.add-editable-html', ->
    current_property = $(this).closest('.cardtec_property')
    new_property = current_property.clone()
    $('.cardtec_property_name', new_property).html("")
    $('.cardtec_property_value', new_property).html("")
    current_property.after(new_property)

  $(document).on 'click touchend', '.remove-editable-html', ->
    $(this).closest('.cardtec_property').remove()

  add_button = () ->
    $('<a>').attr(class: 'button radius add-editable-html', href: '#').append(
      $('<i>').attr(class: "fa fa-plus-circle")
    )

  remove_button = () ->
    $('<a>').attr(class: 'button radius remove-editable-html', href: '#').append(
      $('<i>').attr(class: "fa fa-minus-circle")
    )
  button_wrapper = () ->
    $('<div>').attr(class: '.cardtec_property_actions')

  property_buttons = () ->
    button_wrapper().append(add_button()).append(remove_button())

  $(document).ready ->
    properties = $('#cardtec_card_html .cardtec_property')
    properties.append(property_buttons)



observe_card_contenteditable_save()

