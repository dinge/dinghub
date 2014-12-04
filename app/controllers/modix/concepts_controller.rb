class Modix::ConceptsController < Cardtec::NodesController

  def index
    # @nodes = neo4j_query.match(:n).return(:n).map(&:n)
    @nodes = Modix::Concept.all
  end

  def new
    @node = Modix::Concept.new.to_cardtec_node
  end

  private

    def init_navigation_container_elements
      @navigation_container_elements = neo4j_query.match('(n:Modix)').pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end
end
