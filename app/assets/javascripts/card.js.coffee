
observe_card_contenteditable_save = () ->
  $(document).on 'click touchend', '.update-editable-html', ->
    html_to_save = $('#cardtec_card_html')
    $('<form>').attr(method: 'post', action: window.location.href).append(
      $('<input>').attr(name: '_method', type: 'hidden', value: 'put')
     ).append(
      $('<input>').attr(name: 'cardtec_node[html]', type: 'hiddcoen', value: html_to_save.html())
     ).submit()
      # if html_to_save
      #   path         = $(this).data('editable-path-to-save')
      #   $.ajax
      #     url:  path,
      #     data: { cardtec_node: { html: html_to_save.html() } },
      #     type: 'put'


  $(document).on 'click touchend', '.create-editable-html', ->
    html_to_save = $('#cardtec_card_html')
    path_elements = window.location.pathname.split('/')
    path_elements.pop()
    path = path_elements.join('/')
    $('<form>').attr(method: 'post', action: path).append(
      $('<input>').attr(name: 'cardtec_node[html]', type: 'hidden', value: html_to_save.html())
     ).submit()



observe_card_contenteditable_save()

