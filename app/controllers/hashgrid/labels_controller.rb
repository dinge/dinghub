class Hashgrid::LabelsController < ApplicationController
  layout false

  def index
    @labels = query.match(:n).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
  end

end
