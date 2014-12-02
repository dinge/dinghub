class Modix::Thing < Modix
  include Neo4j::ActiveNode

  property :title
  property :sippe
end
