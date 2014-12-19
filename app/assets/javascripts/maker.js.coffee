window.DH.Maker = {}

window.DH.Maker.Mixer = class Mixer
  constructor: () ->
    @oc = $('#mixer')
    @left_field   = @oc.find('.left')
    @center_field = @oc.find('.center')
    @right_field  = @oc.find('.right')

  add_listener: (selector) ->
    $(document).on 'click', selector, this.add_to_free_empty_field

  reset_fields: () ->
    @oc.find('> div *').remove()

  reset_field: (field) ->
    @oc.find("> div #{field}").remove()

  add_to_free_empty_field: (event) =>
    event.preventDefault()
    left_field_content  = $.trim(@left_field.html())
    right_field_content = $.trim(@right_field.html())

    if !left_field_content
      empty_field = @left_field
    else if !right_field_content
      empty_field = @right_field
    else
      this.reset_fields()
      empty_field = @left_field

    $(event.currentTarget).clone().appendTo(empty_field)

    if $.trim(@left_field.html()) && !$.trim(@right_field.html())
      this.display_related_nodes( this.get_node_id_from_card(@left_field.html()) )
    else if $.trim(@left_field.html()) && $.trim(@right_field.html())
      this.display_relations_to_other_node( this.get_node_id_from_card(@left_field.html()), this.get_node_id_from_card(@right_field.html()))

  display_related_nodes: (node_id) ->
    path = "/maker/relationships/#{node_id}/related_nodes"
    @center_field.load(path)


  display_relations_to_other_node: (first_node_id, second_node_id) ->
    path = "/maker/relationships/between/#{first_node_id}/#{second_node_id}"
    # path = "/maker/relationships/between/d958a2c4-c506-4cd3-bb06-4fc6f53e78da/7deede18-e5e0-4a39-833f-59337cc842fc"
    @center_field.load(path)
    # $.ajax
    #   url: path,
    #   dataType: 'script',
    #   success: (data) =>
    #     @center_field.html(data)


   get_node_id_from_card: (card) ->
    $(card).find('a').last().attr('href').split('/')[3]


window.DH.Maker.OpenCardInDialog = class OpenCardInDialog
  add_listener: (selector) ->
    selector.attr('data-reveal-id', 'dialog').attr('data-reveal-ajax','true')



