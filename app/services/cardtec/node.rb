class Cardtec::Node

  attr_reader :neo_node

  def initialize(neo_node)
    @neo_node = neo_node
  end

  def to_yaml(access_scope = :all)
    Cardtec::TextEncoder.new(neo_node, access_scope).to_yaml
  end

  def to_html(access_scope = :all)
    Cardtec::TextEncoder.new(neo_node, access_scope).to_html
  end

  def update_from_yaml(yaml)
    new_props = Cardtec::TextDecoder::YamlDecoder.new(yaml).to_hash

    labels = new_props.delete(:labels)
    neo_id = new_props.delete(:neo_id)

    neo_node.props = new_props
    neo_node.set_label(*labels)

    neo_node.to_cardtec_node
  end


  # def update_exclusive_props(props)
  #   eclusive_props = {}
  #   neo_node.update_props(eclusive_props)
  # end


  def self.from_yaml(yaml, access_scope = :all)
    Cardtec::YamlDecoder.new(yaml, access_scope).from_yaml
  end


  def method_missing(method, *args)
    neo_node.send(method, *args) if neo_node.respond_to?(method)
  end

end