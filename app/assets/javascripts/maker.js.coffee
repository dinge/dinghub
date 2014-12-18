window.DH.Maker = {}

window.DH.Maker.CardConnector = class CardConnector
  constructor: () ->
    @oc = $('#operations_control')
    @left_field   = @oc.find('.left')
    @center_field = @oc.find('.center')
    @right_field  = @oc.find('.right')

  add_listener: (selector) ->
    $(document).on 'click', selector, this.add_to_free_field

  reset_fields: () ->
    @oc.find('> div *').remove()

  add_to_free_field: (event) =>
    left_field_content  = $.trim(@left_field.html())
    right_field_content = $.trim(@right_field.html())

    if !left_field_content
      field = @left_field
    else if !right_field_content
      field = @right_field
    else
      this.reset_fields()
      field = @left_field

    $(event.currentTarget).clone().appendTo(field)

    if $.trim(@left_field.html()) && $.trim(@right_field.html())
      this.display_relations()

  display_relations: () ->
    console.log("kkk")




window.DH.Maker.OpenCardInDialog = class OpenCardInDialog
  constructor: (selector) ->
    selector.attr('data-reveal-id', 'dialog').attr('data-reveal-ajax','true')



