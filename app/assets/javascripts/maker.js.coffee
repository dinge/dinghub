window.DH.Maker = {}

window.DH.Maker.CardTool = class CardTool
  constructor: (tool_selector) ->
    @te = $(tool_selector)
    this.add_control_listeners()

  add_control_listeners: () ->
    @reset_button     = @te.find('.control button.reset')
    @close_button     = @te.find('.control button.close')
    @minimize_button  = @te.find('.control button.minimize')
    @save_button      = @te.find('.control button.save')

    @reset_button.on 'click', this.reset_tool
    @close_button.on 'click', this.close_tool
    @minimize_button.on 'click', this.minimize_tool
    @save_button.on 'click', this.save_result
    this.toogle_save_button(true)

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
    this.toogle_save_button()
    # implement in subclass and call super()




# window.DH.Maker.OpenCardInDialog = class OpenCardInDialog
#   add_listener: (selector) ->
#     selector.attr('data-reveal-id', 'dialog').attr('data-reveal-ajax', 'true')
