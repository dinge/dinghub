class Modix::ConceptsController < Cardtech::NodesController

  def index
    # @nodes = neo4j_query.match(:n).return(:n).map(&:n)
    @nodes = Modix::Concept.all
  end

end
