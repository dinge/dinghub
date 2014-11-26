class Hashgrid::BaseController < ApplicationController

  before_filter :init_labels


  private

    def init_labels
      @labels = query.match(:n).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort
    end

end
