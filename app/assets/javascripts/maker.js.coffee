window.DH.Maker = {}

window.DH.Maker.CardTool = class CardTool
  constructor: (tool_selector) ->
    @te = $(tool_selector)
    this.add_control_listeners()


  add_control_listeners: () ->
    @save_button = @te.find('.control button.save')
    @te.on 'click', '.control button.minimize', this.minimize_tool
    @te.on 'click', '.control button.close', this.close_tool
    @te.on 'click', '.control button.reset', this.reset_tool
    $(document).on 'click', @save_button.selector, this.save_result
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
