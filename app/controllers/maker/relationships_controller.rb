class Maker::RelationshipsController < Cardtec::ActiveNodesController
  layout false

  def between
    @first_node   = Maker::App.find(params[:first_node])
    @second_node  = Maker::App.find(params[:second_node])
  end

  def related_nodes
    @node = Maker::App.find(params[:id])
  end

end
