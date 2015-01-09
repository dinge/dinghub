class Maker::Concept < Maker::App
  # has_many :out, :parents,  model_class: Maker::Concept,  type:   :is_a
  # has_many :in,  :children, model_class: Maker::Concept,  origin: :parents

  # has_many :out, :parts,    model_class: Maker::Concept,  type:   :part_of
  # has_many :in,  :use_as_parts,    model_class: Maker::Concept,  origin: :parts

  # has_many :out, :connections, model_class: Maker::Concept, type: :connected_to
  # has_many :to, :connections, model_class: Maker::Concept, type: :connected_to


  has_many :out, :traits,   model_class: Maker::Trait,    type: :has_property
  has_many :out, :skills,   model_class: Maker::Skill,    type: :has_method

  has_many :in,  :items,    model_class: Maker::Item,     origin: :concepts

  def connections
    []
  end

end



# Mann benutzt Hammer
# Hammer schlägt Nagel
