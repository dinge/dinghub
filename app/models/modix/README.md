class Me::App
  include Me::NodeTie
end

module Me::NodeTie
  include ActiveSupport::Concern
  included do
    has_many :contributions
    # has_many :contributors
  end
end


class Me::Actor < Me::App # (Subject) Me
  has_many :contributions
end

# class Me::Human < Me::Actor # the
# end

# class Me::Org < Me::Actor # the
# end

# class Me::Bot < Me::Actor # the
# end

class Me::Contribution
  has_one   :actor
  has_one   :thing
end


## -----------------------------------------



class Stater::App
  # include Maker::NodeTie
  include Me::NodeTie
end


# module Maker::NodeTie
#   include ActiveSupport::Concern
#   # included do
#   #   has_many :contributors
#   # end
# end


class Stater::Action < Stater::App  # (Verb) what I possibly can do
  has_many :statements
end

class Stater::Statement < Stater::App # (Triple) the stuff I actually do
  has_one   :actor
  has_one   :action
  has_one   :thing

  has_one   :replies_to # statement
end

## -----------------------------------------


class Maker::App
  Me::NodeTie
end

class Maker::Concept < Maker::App # (Object Concepts)
  has_many :traits
  has_many :methods
  has_many :items

  has_many :parents
end

class Maker::Trait # (Property)
  has_many :used_by
end

class Maker::Method # (active Verb from Item) what can the Item do?
  has_many :used_by
end

  #- consists_of / is_part_of

class Maker::TraitValue < Maker::App # (Propertyvalue)
end


class Maker::Item < Maker::App # () / Thing
  has_many :concepts
end


class Maker::Bundle < Maker::App

end



class Bundler::App
    include ActiveSupport::Concern
    included do
      has_many :contributors
    end
  end

  include NodeTie
end


class Bundler::Bag < Bundler::App
  has_many :parts
end



# Relationships
#   - is_a
#   - instance_of

#   - has_many
#   - has_one