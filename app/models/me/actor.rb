class Me::Actor < Me::App
  has_many :out, :contributions, type: :performs, model_class: Me::Contribution
end
