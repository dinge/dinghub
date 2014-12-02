class Modix::Trait < Modix
  include Neo4j::ActiveNode

  property :title
  property :sippe
end
