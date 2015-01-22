module CardHelper

  def card_element_properties(node, options = {})
    { class: dom_class(node, :card),
      itemscope:  '',
      itemtype:   'http://schema.org/Thing',
      itemid:     node.uuid,
      itemtype:   node.class.schema_path }.merge(options)
  end

  def cardtec_header(node)
    content_tag(:span, node.uuid,       itemprop: :uuid)        <<
    content_tag(:span, node.ident,      itemprop: :ident)       <<
    content_tag(:span, node.class.name, itemprop: :class_name)  <<
    content_tag(:span, node.path,       itemprop: :path)        <<
    content_tag(:span, node.created_at, itemprop: :created_at)  <<
    content_tag(:span, node.updated_at, itemprop: :updated_at)
  end

end


