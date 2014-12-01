
observe_card_contedenteditable_save = () ->
  $(document).on 'click touchend', '.save-editable-html', ->
    html_to_save = $('#cardtect_card_html')
    $('<form>').attr(method: 'post', action: window.location.href).append(
      $('<input>').attr(name: '_method', type: 'hidden', value: 'put')
     ).append(
      $('<input>').attr(name: 'cardtec_node[html]', type: 'hidden', value: html_to_save.html())
     ).submit()

      # if html_to_save
      #   path         = $(this).data('editable-path-to-save')
      #   $.ajax
      #     url:  path,
      #     data: { cardtec_node: { html: html_to_save.html() } },
      #     type: 'put'


observe_card_contedenteditable_save()

