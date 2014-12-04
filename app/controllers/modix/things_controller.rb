class Modix::ThingsController < Cardtec::ActiveNodesController

  def index
    @nodes = Modix::Thing.all
  end

end
