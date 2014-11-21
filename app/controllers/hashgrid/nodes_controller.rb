class Hashgrid::NodesController < ApplicationController

  def index
    @nodes = Neo4j::Session.query.match('n').return(:n).map { |rs| rs.n }
  end

end
