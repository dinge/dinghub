class Me::App
  include Cardtec::ActiveNode



  module Tie
    extend ActiveSupport::Concern
    included do
      has_many :in, :contributions, model_class: Me::Contribution, origin: :thing
    end
  end

end
