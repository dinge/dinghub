class Cardtec::Node

  attr_reader :neo_node

  def initialize(neo_node)
    @neo_node = neo_node
  end

  def to_yaml(access_scope = :all)
    Cardtec::TextEncoder.new(@neo_node, access_scope).to_yaml
  end

  def to_html(access_scope = :all)
    Cardtec::TextEncoder.new(@neo_node, access_scope).to_html
  end


  def self.from_yaml(yaml, access_scope = :all)
    Cardtec::TextDecoder.new(access_scope).from_yaml
  end


  def method_missing(method, *args)
    @neo_node.send(method, *args) if @neo_node.respond_to?(method)
  end

end