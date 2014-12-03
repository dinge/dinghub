module CypherNodeExtension

  def to_cardtec_node
    @cardtec_node ||= Cardtec::Node.new(self)
  end
  alias :ctn :to_cardtec_node

end



module ActiveNodeExtension

  def to_cardtec_node
    node = persisted? ? neo4j_obj : Cardtec::Node::NullNode.new
    @cardtec_node ||= Cardtec::Node.new(node, self.class)
  end
  alias :ctn :to_cardtec_node


  def self.included(base)
    puts base
    base.extend(ClassMethods)
  end


  module ClassMethods

    puts "... "

    def bums
      "bang"
    end

  end

  # def self.bums
  #   "bang"
  # end


end



Neo4j::Server::CypherNode.send(:include, CypherNodeExtension)
Neo4j::ActiveNode.send(:include, ActiveNodeExtension)

# Neo4j::Node