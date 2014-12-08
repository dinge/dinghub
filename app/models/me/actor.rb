class Me::Actor < Me::App
  has_many :out, :contributions, type: 'contributed', model_class: Me::Contribution
end
