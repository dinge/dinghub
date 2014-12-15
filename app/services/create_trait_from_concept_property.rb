class CreateTraitFromConceptProperty


  def node_saved(node, me_current)
    node_klass = node.try(:neo_ruby_klass) || node.class
    if node.is_a?(Maker::Concept)
      node.props.except(*Cardtec::Node::SYSTEM_PROPERTIES).each do |property, value|
        trait = Maker::Trait.where(title: property).first || Maker::Trait.create(title: property)
        unless node.traits.include?(trait)
          node.traits << trait
        end
      end
    end
  end


end

