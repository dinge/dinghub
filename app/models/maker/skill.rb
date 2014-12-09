class Maker::Skill < Maker::App
  has_many :in, :concepts, model_class: Maker::Concept, origin: :skills
end
