jQuery ->
  $.fn.update_with = (response_html, selector) ->
    response_with_wrapper = $('<div>').append(response_html)
    this.html($(response_with_wrapper).find(selector))
    this