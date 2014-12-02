class Modix::ThingsController < Cardtec::NodesController

  def index
    @nodes = Modix::Thing.all
  end

end
