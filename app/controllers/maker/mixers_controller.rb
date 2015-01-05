class Maker::MixersController < Cardtec::ActiveNodesController
  layout false

  def nodes_between
    @node         = Maker::App.find(params[:mixer_id])
    @second_node  = Maker::App.find(params[:second_node_id])
  end

  def related_nodes
    @node = Maker::App.find(params[:id])
  end

end
