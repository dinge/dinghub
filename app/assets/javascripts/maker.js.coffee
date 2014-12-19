window.DH.Maker = {}

window.DH.Maker.Mixer = class Mixer
  constructor: () ->
    @mx = $('#mixer')
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
      this.display_related_nodes( this.node_id_from_card(@lf) )
    else if this.field_content(@lf) && this.field_content(@rf)
      this.display_relations_to_other_node( this.node_id_from_card(@lf), this.node_id_from_card(@rf))

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




window.DH.Maker.OpenCardInDialog = class OpenCardInDialog
  add_listener: (selector) ->
    selector.attr('data-reveal-id', 'dialog').attr('data-reveal-ajax','true')



