class Modix::ThingsController < Cardtec::ActiveNodesController

  def init_side_navigation_items
    @side_navigation_items = Modix::Concept.all
  end

end
