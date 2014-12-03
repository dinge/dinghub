module CypherNodeExtension

  def to_cardtec_node
    @cardtec_node ||= Cardtec::Node.new(self)
  end
  alias :ctn :to_cardtec_node

end


module ActiveNodeExtension

  def to_cardtec_node
    @cardtec_node ||= Cardtec::Node.new(neo4j_obj, self.class)
  end
  alias :ctn :to_cardtec_node

end



Neo4j::Server::CypherNode.send(:include, CypherNodeExtension)
Neo4j::ActiveNode.send(:include, ActiveNodeExtension)

# Neo4j::Node