window.DH.Maker.ClassicEditor = class ClassicEditor extends window.DH.Maker.MakerTool
  constructor: (tool_element) ->
    super(tool_element)

  add_listener: (selector) ->
    $(document).on 'click', selector, this.open_in_editor

  open_in_editor: (event) =>
    # event.stopImmediatePropagation()
    event.preventDefault()

    card        = $(event.currentTarget).closest('.card')
    node_uuid   = $(card).microdata('uuid')
    large_card  = $('.show-in-classic-editor .large-card:first')

    if large_card.length && large_card.microdata('uuid') == node_uuid
      this.close()
    else
      this.open(card)

  close: () =>
    $('.show-in-classic-editor').hide().html('')
    $('.new-in-classic-editor').show()
    @te.hide()

  open: (card) ->
    @te.show()
    path = card.microdata('path')
    $('html, body').animate({scrollTop:0}, 'fast');
    $('.new-in-classic-editor').hide()
    $('.show-in-classic-editor').load path, ->
      $('.show-in-classic-editor').show()
      $(document).foundation('tab', 'reflow');
      pfe = new DH.Card.AddPropertyFieldEditor
      pfe.add_control_fields()
      $('.show-in-classic-editor .close_button').on 'click', ->
        ed = new DH.Maker.ClassicEditor
        ed.close()



window.DH.Maker.ClassicEditorButtonObserver = class ClassicEditorButtonObserver
  add_listener: () ->
    $(document).on 'click', '.create-editable-html', this.create_card
    $(document).on 'click', '.update-editable-html', this.update_card
    $(document).on 'keypress', this.save_on_keypress

  create_card: () =>
    card_to_save  = $('.new-in-classic-editor > .card:visible:first')
    path          = card_to_save.microdata('path')
    if card_to_save && path
      $.ajax path,
        data: { cardtec_node: { html: card_to_save.html() } }
        type: 'POST'
        dataType: 'script'

  update_card: () =>
    card_to_save  = $('.show-in-classic-editor > .card:visible:first')
    path          = card_to_save.microdata('path')
    if card_to_save && path
      $.ajax
        url:  path
        data: { cardtec_node: { html: card_to_save.html() } }
        type: 'PUT'
        dataType: 'script'

  save_on_keypress: () =>
    if event.which == 13 && event.ctrlKey
      event.preventDefault()
      if $('.update-editable-html:visible').length == 1
        this.update_card()
      else if $('.create-editable-html:visible').length == 1
        this.create_card()
      false
    else
      true


os = new ClassicEditorButtonObserver
os.add_listener()


