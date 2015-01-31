window.DH.Maker.Mixer = class Mixer extends window.DH.Maker.MakerTool
  constructor: (tool_selector) ->
    super(tool_selector)
    this.toogle_save_button(true)
    this.init_fields()

  init_fields: () ->
    @shelf        = @te.find('.shelf')
    @shelf_left   = @shelf.find('.left')
    @shelf_center = @shelf.find('.center')
    @shelf_right  = @shelf.find('.right')
    @op           = @te.find('.operator')
    this.add_relationship_type_listener()

  add_listener: (selector) ->
    $(document).on 'click', selector, this.add_to_free_empty_field

  add_relationship_type_listener: () ->
    @te.on 'click', '.operator .relationship_type', this.toggle_relationship_type_assigment

  toggle_relationship_type_assigment: (event) =>
    this.vizualize_relationship_type_assigment($(event.target))

  add_new_relationship_type_listener: () ->
    $('.new_relationship_type').on 'keypress', =>
      if event.which is 13
        new_relationship_type_input = @op.find('.new_relationship_type')
        new_relationship_type = DH.Util.cleanup(new_relationship_type_input.val())

        existing_relationship_type = this.find_relationship_type(new_relationship_type)
        new_relationship_type_button = if existing_relationship_type.length >= 1
          existing_relationship_type
        else
          $('<button>').addClass('relationship_type fresh').html(new_relationship_type).prependTo(@op.find('.relationship_types'))

        new_relationship_type_input.val('')
        this.vizualize_relationship_type_assigment(new_relationship_type_button)

   find_relationship_type: (relationship_type) ->
      @op.find('.relationship_types .relationship_type').filter(->
        DH.Util.cleanup($(this).text()) is relationship_type
      ).first()

   vizualize_relationship_type_assigment: (pressed_relationship_type_button) ->
    predicate_field = @shelf.find('.predicate')
    relationship_type_vizual = $('<button>').addClass('large relationship_type active')
      .html(DH.Util.cleanup(pressed_relationship_type_button.text()))

    if ! pressed_relationship_type_button.hasClass('active')
      predicate_field.html(relationship_type_vizual)
      @op.find('.relationship_types .relationship_type.active').removeClass('active')
      pressed_relationship_type_button.addClass('active')
      this.toogle_save_button() if @save_button.prop('disabled')
    else
      predicate_field.html('???')
      pressed_relationship_type_button.removeClass('active')
      this.toogle_save_button() unless @save_button.prop('disabled')

  add_to_free_empty_field: (event) =>
    event.preventDefault()
    @te.show()

    empty_field =
      if !this.field_content(@shelf_left)
        @shelf_left
      # else if !this.field_content(@shelf_right)
      else if !this.field_content(@shelf_right) or @shelf_right.find('.card').length == 0
        this.reset_shelf_field('.right')
        @shelf_right
      else
        # this.reset_shelf_field('.right')
        # @shelf_right
        this.reset_tool()
        @shelf_left

    $(event.currentTarget).clone().appendTo(empty_field)

    if this.field_content(@shelf_left) && !this.field_content(@shelf_right)
      this.display_related_nodes(this.parse_node_id_from_field(@shelf_left))
    else if this.field_content(@shelf_left) && this.field_content(@shelf_right)
      this.display_relations_to_other_node(this.parse_node_id_from_field(@shelf_left), this.parse_node_id_from_field(@shelf_right))

  display_related_nodes: (node_id) ->
    path = "/maker/mixers/#{node_id}/related_nodes"
    $.get(path, (html) =>
      @shelf_center.update_with(html, '.rel_types_with_nodes_to')
      @shelf_right.update_with(html, '.rel_types_with_nodes_from')
      $(document).foundation('tooltip', 'reflow');
    )


  display_relations_to_other_node: (first_node_id, last_node_id) ->
    path = "/maker/mixers/#{first_node_id}/relationships_between/#{last_node_id}"
    $.get(path, (html) =>
      @shelf_center.update_with(html, '.connector')
      @op.update_with(html, '.relationship_type_editor')
      this.add_new_relationship_type_listener()
      @op.find('.new_relationship_type').focus() if ! DH.Util.is_ipad()
    )

  save_result: (event) =>
    cardtec_message = @shelf_center.find('.connector').parent().html()
    $.post('/maker/mixers/', { cardtec_message: cardtec_message } )
    this.reset_shelf_field('.right')
    this.reset_shelf_field('.center')
    this.reset_operator()
    this.toogle_save_button()

  reset_tool: () ->
    this.reset_shelf()
    @op.html('')

  reset_shelf: () ->
    @shelf.find('> div *').remove()

  reset_shelf_field: (field) ->
    @shelf.find("> div#{field}").html('')

  reset_operator: () ->
    @op.html('')

  field_content: (field) ->
    DH.Util.cleanup(field.html())



