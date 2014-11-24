module Cardtec

  def self.query
    neo_query = Neo4j::Session.query
    # neo_query.extend(Neo4jQueryExtension)
    neo_query
  end


  # module Neo4jQueryExtension

  #   def to_cardtec_node

  #   end

  # end

end