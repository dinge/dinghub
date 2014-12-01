class Modix::ConceptsController < Cardtec::NodesController

  def index
    # @nodes = neo4j_query.match(:n).return(:n).map(&:n)
    @nodes = Modix::Concept.all
  end

  def new
    @node = Modix::Concept.new.to_cardtec_node
  end

end
