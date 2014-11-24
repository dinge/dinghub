class Cardtec::Node

  attr_reader :neo_node

  def initialize(neo_node)
    @neo_node = neo_node
  end

  def method_missing(method, *args)
    @neo_node.send(method, *args) if @neo_node.respond_to?(method)
  end

  def to_yaml
    Cardtec::TextEncoder.new(@neo_node).to_yaml
  end

  def to_html
    Cardtec::TextEncoder.new(@neo_node).to_html
  end

end