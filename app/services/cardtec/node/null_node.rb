class Cardtec::Node::NullNode < OpenStruct
  def props
    {}
  end

  def to_cardtec_node
    @cardtec_node ||= Cardtec::Node.new(self)
  end
  alias :ctn :to_cardtec_node
end
