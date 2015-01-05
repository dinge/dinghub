window.DH.Maker = {}

window.DH.Maker.Mixer = class Mixer
  constructor: (mixer_element) ->
    @mx = $(mixer_element)
    @lf = @mx.find('.left')
    @cf = @mx.find('.center')
    @rf = @mx.find('.right')

  add_listener: (selector) ->
    $(document).on 'click', selector, this.add_to_free_empty_field

  reset_fields: () ->
    @mx.find('> div *').remove()

  reset_field: (field) ->
    @mx.find("> div #{field}").remove()

  add_to_free_empty_field: (event) =>
    event.preventDefault()

    empty_field =
      if !this.field_content(@lf)
        @lf
      else if !this.field_content(@rf)
        @rf
      else
        this.reset_fields()
        @lf

    $(event.currentTarget).clone().appendTo(empty_field)

    if this.field_content(@lf) && !this.field_content(@rf)
      this.display_related_nodes(this.node_id_from_card(@lf))
    else if this.field_content(@lf) && this.field_content(@rf)
      this.display_relations_to_other_node(this.node_id_from_card(@lf), this.node_id_from_card(@rf))

  display_related_nodes: (node_id) ->
    path = "/maker/relationships/#{node_id}/related_nodes"
    @cf.load(path)

  display_relations_to_other_node: (first_node_id, second_node_id) ->
    path = "/maker/relationships/between/#{first_node_id}/#{second_node_id}"
    @cf.load(path)


  field_content: (field) ->
    $.trim(field.html())

  node_id_from_card: (card) ->
    $(card).find('a').last().attr('href').split('/')[3]




window.DH.Maker.Editor = class Mixer
  constructor: (editor_element) ->
    @ed = $(editor_element)

  add_listener: (selector) ->
    $(document).on 'click', selector, this.open_in_editor

  open_in_editor: (event) =>
    event.stopImmediatePropagation()
    event.preventDefault()

    card        = $(event.currentTarget)
    node_uuid   = $(card).microdata('uuid')
    large_card  = $('#show_in_editor .large-card:first')

    if large_card.length && large_card.microdata('uuid') == node_uuid
      this.close()
    else
      this.open(card)

  close: () =>
    $('#show_in_editor').hide().html('')
    $('#new_in_editor').fadeIn(100)

  open: (card) ->
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


window.DH.Maker.OpenCardInDialog = class OpenCardInDialog
  add_listener: (selector) ->
    selector.attr('data-reveal-id', 'dialog').attr('data-reveal-ajax','true')



