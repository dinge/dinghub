module Me::NodeTie
  extend ActiveSupport::Concern

  included do
    has_many :out, :contributions, model_class: Me::Contribution, origin: :thing
  end
end
