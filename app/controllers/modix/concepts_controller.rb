class Modix::ConceptsController < Cardtec::ActiveNodesController

  def init_side_navigation_items
    @side_navigation_items = Modix::Concept.all
  end

  # def init_filtered_nodes
  #   @nodes = neo4j_query.match(n: params[:filter]).where("n:`#{model_klass_name_space}`").return(:n).map(&:n)
  # end

  # def filtered
  #   init_filtered_nodes
  #   init_side_navigation_items
  #   render :index
  # end

end
