module Cardtec::Node::Updater

  def update_from_yaml(yaml)
    update_from_text_decoder(text_decoder_instance.from_yaml(yaml))
  end

  def update_from_html(html)
    update_from_text_decoder(text_decoder_instance.from_html(html))
  end

  # def text_decoder_instance
  #   Cardtec::TextDecoder.new(self)
  # end

  def update_from_text_decoder(text_decoder)
    new_props = text_decoder.to_hash
    labels = new_props.delete(:labels)
    neo_id = new_props.delete(:neo_id)

    new_and_old_props = neo_node.props.slice(*Cardtec::Node::PROPERTIES_TO_KEEP).merge(new_props.symbolize_keys)

    neo_node.props = new_and_old_props
    neo_node.set_label(*labels) if labels.present?
    notify_to_after_save_listeners
  end


end
