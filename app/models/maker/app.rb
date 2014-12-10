class Maker::App
  include Cardtec::ActiveNode
  include Me::App::Tie

  module Tie
    extend ActiveSupport::Concern
    included do
      has_many :in, :bundles, model_class: Maker::Bundle, origin: :things
    end
  end

  include Tie
end
