module CypherNodeExtension
  def method_missing(method, *args)
    if props.key?(method)
      props[method]
    else
      super
    end
  end

  def to_cardtec_node
    Cardtec::Node.new(self)
  end
end

module ActiveNodeExtension
  def to_cardtec_node
    Cardtec::Node.new(self)
  end
end



Neo4j::Server::CypherNode.send(:include, CypherNodeExtension)
Neo4j::ActiveNode.send(:include, ActiveNodeExtension)

# Neo4j::Node