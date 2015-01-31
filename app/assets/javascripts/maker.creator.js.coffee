window.DH.Maker.Creator = class Creator extends window.DH.Maker.MakerTool
  constructor: (tool_element) ->
    super(tool_element)
    @op = @te.find('.maker-creator-operator')

  save_result: (event) =>
    path          = '/maker/creator'
    card_to_save  = @te.find('.maker-creator-operator')
    if card_to_save && path
      $.ajax path,
        data: { cardtec_node: { html: card_to_save.html() } }
        type: 'POST'
        dataType: 'html'
      .done (response) =>
        @op.update_with(response, '.cardtec-card')