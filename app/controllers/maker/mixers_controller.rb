class Maker::MixersController < Cardtec::ActiveNodesController
  layout false

  def relationships_between
    @first_node = Maker::App.find(params[:mixer_id])
    @last_node  = Maker::App.find(params[:last_node_id])

    @all_relationship_types = Graph8.all_relationship_types
  end

  def related_nodes
    @node = Maker::App.find(params[:id])
  end

  def cardtec_tunnel
    render :nothing => true
    # binding.pry
  end

end
