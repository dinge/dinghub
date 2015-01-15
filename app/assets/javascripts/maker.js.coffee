window.DH.Maker = {}

window.DH.Maker.Mixer = class Mixer
  constructor: (mixer_element) ->
    @mx = $(mixer_element)
    @shelf        = @mx.find('.shelf')
    @shelf_left   = @shelf.find('.left')
    @shelf_center = @shelf.find('.center')
    @shelf_right  = @shelf.find('.right')
    @op           = @mx.find('.operator')
    this.add_relationship_type_listener()

  add_listener: (selector) ->
    $(document).on 'click', selector, this.add_to_free_empty_field

  add_relationship_type_listener: () ->
    $(document).on 'click', @mx.find('.relationship_type'), this.toggle_relationship_assigment

  toggle_relationship_assigment: (event) ->
    relationship_type = $(event.target).text()
    console.log $.trim(relationship_type)

  add_new_relationship_type_listener: () ->
    $('.new_relationship_type').on 'keypress', =>
      if event.which == 13
        nrte = @op.find('.new_relationship_type')
        rte = $('<button>').addClass('relationship_type active').html($.trim(nrte.val()))
        rte.prependTo(@op.find('.relationship_types'))
        nrte.val('')

  reset_all: () ->
    this.reset_shelf()
    @op.html('')

  reset_shelf: () ->
    @shelf.find('> div *').remove()

  # reset_field: (field) ->
  #   @mx.find("> div #{field}").remove()

  add_to_free_empty_field: (event) =>
    event.preventDefault()
    @mx.show()

    empty_field =
      if !this.field_content(@shelf_left)
        @shelf_left
      else if !this.field_content(@shelf_right)
        @shelf_right
      else
        this.reset_all()
        @shelf_left

    $(event.currentTarget).clone().appendTo(empty_field)

    if this.field_content(@shelf_left) && !this.field_content(@shelf_right)
      this.display_related_nodes(this.parse_node_id_from_field(@shelf_left))
    else if this.field_content(@shelf_left) && this.field_content(@shelf_right)
      this.display_relations_to_other_node(this.parse_node_id_from_field(@shelf_left), this.parse_node_id_from_field(@shelf_right))

  display_related_nodes: (node_id) ->
    path = "/maker/mixers/#{node_id}/related_nodes"
    # @shelf_center.load(path)

  display_relations_to_other_node: (first_node_id, second_node_id) ->
    path = "/maker/mixers/#{first_node_id}/relationships_between/#{second_node_id}"
    $.get(path, (html) =>
      @shelf_center.update_with(html, '.connector')
      @op.update_with(html, '.relationship_type_editor')
      this.add_new_relationship_type_listener()
      @op.find('.new_relationship_type').focus()
    )



  field_content: (field) ->
    $.trim(field.html())

  parse_node_id_from_field: (field) ->
    field.find('.card').microdata('uuid')



window.DH.Maker.Editor = class Editor
  constructor: (editor_element) ->
    @ed = $(editor_element)

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



window.DH.Maker.OpenCardInDialog = class OpenCardInDialog
  add_listener: (selector) ->
    selector.attr('data-reveal-id', 'dialog').attr('data-reveal-ajax', 'true')



window.DH.Maker.Controls = class Controls
  constructor: (selector) ->

  # # for delay look:
  # http://stackoveshelf_rightlow.com/questions/1909441/jquery-keyup-delay
  # https://github.com/nashelf_rightdotpl/jquery-typing
  add_search: (selector) ->
    $(selector).on 'input', ->
      search_term = $(this).val()
      $.get "/maker/concepts/search?search_term=#{search_term}"

  add_control_listeners: () ->
      $('#open_editor').on 'click', (event) ->
        $('#editor').toggle()
        event.preventDefault()
      $('#open_mixer').on 'click', (event) ->
        $('#mixer').toggle()
        event.preventDefault()
