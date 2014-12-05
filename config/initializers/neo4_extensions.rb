module CypherNodeExtension

  def to_cardtec_node
    @cardtec_node ||= Cardtec::Node.new(self)
  end
  alias :ctn :to_cardtec_node

  def to_param
    neo_id
  end

end



# module ActiveNodeExtension

#   def to_cardtec_node
#     node = persisted? ? neo4j_obj : Cardtec::Node::NullNode.new
#     @cardtec_node ||= Cardtec::Node.new(node, self.class)
#   end
#   alias :ctn :to_cardtec_node

# end


Neo4j::Server::CypherNode.send(:include, CypherNodeExtension)
#Neo4j::ActiveNode.send(:include, ActiveNodeExtension)
#Neo4j::ActiveNode.extend(ActiveNodeClassExtension)

# Neo4j::Node