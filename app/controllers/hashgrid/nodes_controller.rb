class Hashgrid::NodesController < ApplicationController
  layout false

  before_filter :init_cardtec_node, only: [:show, :update]

  def index
    @nodes = query.match(:n).return(:n).map(&:n)
  end

  def show; end

  def update
    @cardtec_node.update_from_yaml(params[:yaml])
    render :nothing => true
  end

  def by_label
    @nodes = query.match(n: params[:label]).return(:n).map(&:n)
    render :index
  end



  private

    def init_cardtec_node
      @cardtec_node = Cardtec.query.match(:n).where(n: { neo_id: params[:id] }).return(:n).first.n.to_cardtec_node
    end

end
