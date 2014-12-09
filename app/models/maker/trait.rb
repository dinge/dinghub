class Maker::Trait < Maker::App
  has_many :in, :concepts, model_class: Maker::Concept, origin: :traits
end
