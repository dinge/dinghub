class Hashgrid::NodeControlsController < ApplicationController
  # layout false

  def index
    @node_controls = [:add, :edit, :destroy]
  end

end
