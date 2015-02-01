window.DH.Maker.ControlBar = class ControlBar
  constructor: (selector) ->
    @cbe = $(selector)

  add_control_listeners: () ->
    @cbe.find('.open_creator').on 'click', (event) ->
      $('.maker-creator').toggle()
      event.preventDefault()
    @cbe.find('.open_editor').on 'click', (event) ->
      $('#editor').toggle()
    @cbe.find('.open_classic_editor').on 'click', (event) ->
      $('.classic-editor').toggle()
      event.preventDefault()
    @cbe.find('.open_mixer').on 'click', (event) ->
      $('#mixer').toggle()
      event.preventDefault()
