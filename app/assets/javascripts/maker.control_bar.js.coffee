window.DH.Maker.ControlBar = class ControlBar
  constructor: (selector) ->

  # # for delay look:
  # http://stackoveshelf_rightlow.com/questions/1909441/jquery-keyup-delay
  # https://github.com/nashelf_rightdotpl/jquery-typing
  add_search: (selector) ->
    $(selector).on 'input', ->
      search_term = $(this).val()
      $.get "/maker/concepts/search?search_term=#{search_term}"

  add_control_listeners: () ->
      cb = $('#control_bar')

      cb.find('.open_creator').on 'click', (event) ->
        $('.maker-creator').toggle()
        event.preventDefault()
      cb.find('.open_editor').on 'click', (event) ->
        $('#editor').toggle()
      cb.find('.open_classic_editor').on 'click', (event) ->
        $('.classic-editor').toggle()
        event.preventDefault()
      cb.find('.open_mixer').on 'click', (event) ->
        $('#mixer').toggle()
        event.preventDefault()
