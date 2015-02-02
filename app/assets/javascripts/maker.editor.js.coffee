window.DH.Maker.Editor = class Editor extends window.DH.Maker.MakerTool
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
    # $('#show_in_editor').hide().html('')
    # $('#new_in_editor').fadeIn(100)
    $('.maker-editor').hide()

  open: (card) ->
    $('.maker-editor').show()
    path = card.microdata('path')
    this.scroll_to_top()
    $('#show_in_editor').load path, ->
      $('#show_in_editor').show()
      $(document).foundation('tab', 'reflow');
      pfe = new DH.Card.AddPropertyFieldEditor
      pfe.add_control_fields()
