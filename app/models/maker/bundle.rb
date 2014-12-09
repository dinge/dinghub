class Maker::Bundle < Maker::App
  has_many :out, :things, model_class: false, type: :contains
end
