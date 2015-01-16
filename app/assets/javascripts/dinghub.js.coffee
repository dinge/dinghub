window.DH = {};

window.DH.Util = class Util
  @is_ipad: () ->
    navigator.platform.indexOf('iPad') != -1

  @cleanup: (string) ->
    $.trim(string)
