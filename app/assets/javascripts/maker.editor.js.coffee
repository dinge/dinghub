window.DH.Maker.Editor = class Editor extends window.DH.Maker.CardTool
  constructor: (tool_element) ->
    super(tool_element)

  add_listener: (selector) ->
    $(document).on 'click', selector, this.open_in_editor

  open_in_editor: (event) =>
    # event.stopImmediatePropagation()
    event.preventDefault()

    card        = $(event.currentTarget).closest('.card')
    node_uuid   = $(card).microdata('uuid')
    large_card  = $('#show_in_editor .large-card:first')

    if large_card.length && large_card.microdata('uuid') == node_uuid
      this.close()
    else
      this.open(card)

  close: () =>
    $('#show_in_editor').hide().html('')
    $('#new_in_editor').fadeIn(100)
    $('#editor').hide()

  open: (card) ->
    $('#editor').show()
    path = card.microdata('path')
    $('html, body').animate({scrollTop:0}, 'fast');
    $('#new_in_editor').hide()
    $('#show_in_editor').load path, ->
      $('#show_in_editor').fadeIn(100)
      $(document).foundation('tab', 'reflow');
      pfe = new DH.Card.AddPropertyFieldEditor
      pfe.add_control_fields()
      $('#show_in_editor .close_button').on 'click', ->
        ed = new DH.Maker.Editor
        ed.close()
