window.DH.Maker.ControlBar = class ControlBar
  constructor: (selector) ->
    @cbe = $(selector)

  add_control_listeners: () ->
    $('#control_bar').on 'click', 'button', (event) =>
      if maker_tool_ident = $(event.target).data('maker-tool')
        $('.' + maker_tool_ident).toggle()
