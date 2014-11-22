class Hashgrid::NodesController < ApplicationController
  layout false

  def index
    @nodes = query.match(:n).return(:n).map(&:n)
  end

  def show
    @node = query.match(:n).where(n: { neo_id: params[:id] }).return(:n).first.n
  end

  def by_label
    @nodes = query.match(n: params[:label]).return(:n).map(&:n)
    render :index
  end

end
