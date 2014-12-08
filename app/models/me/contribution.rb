class Me::Contribution < Me::App
  has_one :in,  :contributor, model_class: Me::Actor, origin: :contributions
  has_one :out, :thing, type: 'contributed_to', model_class: false
end
