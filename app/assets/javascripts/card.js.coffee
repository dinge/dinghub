window.DH.Card = {}

window.DH.Card.AddPropertyFieldEditor = class AddPropertyFieldEditor
  init: () ->
    this.add_listener()
    this.focus_first_property_value()
    this.add_control_fields()

  add_listener: () ->
    $(document).on 'click', '.add-editable-html', (event) ->
      current_property = $(this).closest('.cardtec_property')
      new_property = current_property.clone()
      $('.cardtec_property_name', new_property).html('')
      $('.cardtec_property_value', new_property).html('')
      current_property.after(new_property)

    $(document).on 'click', '.remove-editable-html', ->
      $(this).closest('.cardtec_property').remove()


  add_control_fields: () ->
    add_button = () ->
      $('<button>').attr(class: 'button radius add-editable-html').append($('<i>').attr(class: 'fa fa-plus-circle'))
    remove_button = () ->
      $('<button>').attr(class: 'button radius remove-editable-html').append($('<i>').attr(class: 'fa fa-minus-circle'))
    button_wrapper = () ->
      $('<div>').attr(class: 'cardtec_property_actions')
    property_buttons = () ->
      button_wrapper().append(add_button()).append(remove_button())

    properties = $('.cardtec_card_html .cardtec_property:not(:has(div.cardtec_property_actions))')
    properties.append(property_buttons)


  focus_first_property_value: () ->
    $('.cardtec_property_value:visible:first').focus()



window.DH.Card.ObserveSave = class ObserveSave
  add_listener: () ->
    $(document).on 'click', '.create-editable-html', this.create_card
    $(document).on 'click', '.update-editable-html', this.update_card
    $(document).on 'keypress', this.save_on_keypress

  create_card: () =>
    card_to_save  = $('#new_in_editor > .card:visible:first')
    path          = card_to_save.microdata('path')
    if card_to_save && path
      $.ajax path,
        data: { cardtec_node: { html: card_to_save.html() } }
        type: 'POST'
        dataType: 'script'

  update_card: () =>
    card_to_save  = $('#show_in_editor > .card:visible:first')
    path          = card_to_save.microdata('path')
    if card_to_save && path
      $.ajax
        url:  path
        data: { cardtec_node: { html: card_to_save.html() } }
        type: 'PUT'
        dataType: 'script'

  save_on_keypress: () =>
    if event.which == 13 && event.ctrlKey
      event.preventDefault()
      if $('.update-editable-html:visible').length == 1
        this.update_card()
      else if $('.create-editable-html:visible').length == 1
        this.create_card()
      false
    else
      true



os = new ObserveSave
os.add_listener()

pfe = new AddPropertyFieldEditor
pfe.init()

