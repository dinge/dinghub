window.DH.GLobalSearch = class GLobalSearch
  constructor: (selector) ->
    @se = $(selector)

  add_listener: () ->
    @se.on 'input', ->
      search_term = $(this).val()
      DH.Util.delay (->
        $.get '/maker/concepts/search?search_term=' + search_term
      ), 500

