module CardHelper


  def card_props(node)
    { class: dom_class(node, :card),
      'data-card-path' => current_show_path(node),
      'data-card-uuid' => node.uuid,
      itemscope:  '',
      itemtype:   'http://schema.org/Thing',
      itemid:     node.uuid }
  end

  def cardtec_header(node)
    content_tag(:span, node.uuid, itemprop: :uuid) <<
    content_tag(:span, node.ident, itemprop: :ident) <<
    content_tag(:span, node.class.name, itemprop: :class_name) <<
    content_tag(:span, node.class.name, itemprop: :class_name) <<
    content_tag(:span, node.class.name.tableize, itemprop: :class_path) <<
    content_tag(:span, current_show_path(node), itemprop: :path) <<
    content_tag(:span, node.created_at, itemprop: :created_at) <<
    content_tag(:span, node.updated_at, itemprop: :updated_at)
  end

end