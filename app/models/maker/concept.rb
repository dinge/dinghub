class Maker::Concept < Maker::App
  has_many :out, :traits, model_class: Maker::Trait, type: :has_property
  has_many :out, :skills, model_class: Maker::Skill, type: :has_method

  has_many :in,  :items,  model_class: Maker::Item,  origin: :concepts


  # has_many :items
  # has_many :parents
end
