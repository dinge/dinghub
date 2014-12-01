class Modix::ThingsController < Cardtech::NodesController

  def index
    @nodes = Modix::Thing.all
  end

end
