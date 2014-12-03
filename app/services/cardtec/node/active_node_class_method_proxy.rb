class Cardtec::Node::ActiveNodeClassMethodProxy
  include Cardtec::Node::Creater

  def initialize(neo_ruby_klass)
    @neo_ruby_klass = neo_ruby_klass
  end

  def create_from_text_decoder(text_decoder) # overwriting Cardtec::Node::ClassMethods#create_from_text_decoder
    new_props = text_decoder.to_hash

    labels = new_props.delete(:labels)
    neo_id = new_props.delete(:neo_id)
    @neo_ruby_klass.create(new_props)
  end

end
