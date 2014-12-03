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

    neo_node.props = new_props
    neo_node.set_label(*labels) if labels.present?
  end


end
