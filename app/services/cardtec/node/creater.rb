module Cardtec::Node::Creater

  def create_from_yaml(yaml)
    create_from_text_decoder(text_decoder_instance.from_yaml(yaml))
  end

  def create_from_html(html)
    create_from_text_decoder(text_decoder_instance.from_html(html))
  end

  def text_decoder_instance
    Cardtec::TextDecoder.new(self)
  end

  def create_from_text_decoder(text_decoder)
    new_props = text_decoder.to_hash
    labels = new_props.delete(:labels)
    neo_id = new_props.delete(:neo_id)

    Neo4j::Node.create(new_props, *labels)
  end

end
