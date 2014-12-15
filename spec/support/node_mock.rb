class NodeMock
  def labels
    [:Item]
  end

  def neo_id
    22
  end

  def props
    { title:    'Kerze',
      ident:    'item-44',
      uuid:     'xyz',
      body:     'ist aus Wachs',

      image_url: 'http://image.url',
      created_at: DateTime.parse('2014-11-24 13:11:22').to_s,
      updated_at: DateTime.parse('2014-11-24 13:11:22').to_s,

      height:   35,
      weight:   240,
      color:    'rot' }
  end

  # def method_missing(method, *args)
  #   props[method] if props.has_key?(method)
  # end
end
