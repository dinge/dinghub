class Franky
  has_one  :creator
  has_many :in_bundles
end


class Me

end


class Me::Actor # (Subject) Me
  has_many :creations
end

class Me::Org
end



class Me::Action # (Verb) what can I do
end

class Me::Statement # (Triple) the stuff I actually do
  has_one   :actor
  has_many  :actions
  has_many  :items
end





class Concept # (Object Concepts)
  has_many :properties
  has_many :methods
  has_many :parents

  has_many :item
end

class Trait # (Property)
  has_many :used_by
end

class Method # (active Verb from Item) what can the Item do?
  has_many :used_by
end

  #- consists_of / is_part_of

class TraitValue # (Propertyvalue)
end


class Item # () / Thing
  has_many :concepts
end






class Bundle
  has_many :parts
end

class Facets
end


# Relationships
#   - is_a
#   - instance_of

#   - has_many
#   - has_one