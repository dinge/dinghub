window.DH.Maker.ControlBar = class ControlBar
  constructor: (selector) ->
    @cbe = $(selector)

  add_control_listeners: () ->
    @cbe.find('.open_creator').on 'click', (event) ->
      $('.maker-creator').toggle()
      event.preventDefault()
    @cbe.find('.open_editor').on 'click', (event) ->
      $('.maker-editor').toggle()
    @cbe.find('.open_classic_editor').on 'click', (event) ->
      $('.maker-classic-editor').toggle()
      event.preventDefault()
    @cbe.find('.open_mixer').on 'click', (event) ->
      $('.maker-mixer').toggle()
      event.preventDefault()
