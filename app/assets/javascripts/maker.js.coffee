window.DH.Maker = {}

window.DH.Maker.MakerTool = class MakerTool
  constructor: (tool_selector) ->
    @te = $(tool_selector)
    this.add_control_listeners()

  add_control_listeners: () ->
    @reset_button     = @te.find('button.reset')
    @close_button     = @te.find('button.close')
    @minimize_button  = @te.find('button.minimize')
    @save_button      = @te.find('button.save')

    @reset_button.on 'click', this.reset_tool
    @close_button.on 'click', this.close_tool
    @minimize_button.on 'click', this.minimize_tool
    @save_button.on 'click', this.save_result

  toogle_save_button: (initial) ->
    @save_button.prop 'disabled', (i, v) ->
      not v
    @save_button.toggleClass('success') unless initial

  minimize_tool: () =>
    @te.toggle()

  close_tool: () =>
    this.minimize_tool()
    this.reset_tool()

  reset_tool: () =>
    # implement in subclass

  save_result: () =>
    # implement in subclass

  parse_node_id_from_field: (field) ->
    field.find('.card').microdata('uuid')
    # field.find('.card').properties('uuid').itemValue()

  scroll_to_top: () ->
    $('html, body').animate({scrollTop:0}, 'fast');



# window.DH.Maker.OpenCardInDialog = class OpenCardInDialog
#   add_listener: (selector) ->
#     selector.attr('data-reveal-id', 'dialog').attr('data-reveal-ajax', 'true')
