window.DH = {};

window.DH.Util = class Util
  @is_ipad: () ->
    navigator.platform.indexOf('iPad') != -1

  @cleanup: (string) ->
    $.trim(string)

  @delay: (callback, ms) ->
    timer = 0
    do (callback, ms) ->
      clearTimeout (timer)
      timer = setTimeout(callback, ms)