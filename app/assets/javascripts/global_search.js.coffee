window.DH.GLobalSearch = class GLobalSearch
  constructor: (selector) ->
    @se = $(selector)

  # # for delay look:
  # http://stackoveshelf_rightlow.com/questions/1909441/jquery-keyup-delay
  # https://github.com/nashelf_rightdotpl/jquery-typing
  add_listener: () ->
    @se.on 'input', ->
      search_term = $(this).val()
      $.get "/maker/concepts/search?search_term=#{search_term}"
