class Maker::MixersController < Cardtec::ActiveNodesController
  layout false

  def relationships_between
    @node         = Maker::App.find(params[:mixer_id])
    @second_node  = Maker::App.find(params[:second_node_id])

    @all_relationship_types = Graph8.all_relationship_types
  end

  def related_nodes
    @node = Maker::App.find(params[:id])
  end

end
