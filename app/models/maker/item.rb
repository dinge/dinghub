class Maker::Item < Maker::App
  has_many :out, :concepts, model_class: Maker::Concept, type: :instance_of
end
