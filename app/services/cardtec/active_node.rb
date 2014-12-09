module Cardtec::ActiveNode
  extend  ActiveSupport::Concern

  included do
    include Neo4j::ActiveNode
    include GlobalID::Identification
    extend ClassMethods

    property  :title,       type: String
    property  :body,        type: String
    property  :image_url,   type: String
    property  :ident,       type: String
    property  :created_at
    property  :updated_at

    delegate :relationship_methods, :association_methods, :core_relationship_types, to: :class
  end


  def to_cardtec_node
    node = persisted? ? neo4j_obj : Cardtec::Node::NullNode.new
    @cardtec_node ||= Cardtec::Node.new(node, self.class)
  end
  alias :ctn :to_cardtec_node




  def all_related_nodes
    # replace with with cypher query
    Struct.new(*association_methods).new(*association_methods.map { |m| send(m).to_a } )
  end




  module ClassMethods
    def to_cardtec_node
      Cardtec::Node::ActiveNodeClassMethodProxy.new(self)
    end
    alias :ctn :to_cardtec_node


    def relationship_methods
      associations.keys.map { |a| "#{a}_rels".to_sym }
    end

    def association_methods
      associations.keys
    end

    def core_relationship_types
      associations.values.map { |a| a.relationship_type }
    end

  end

end









# module Extensions::Neo4jCommon

#   module ClassMethods

#     def reflect_on_association(reflection)
#       _decl_rels[reflection.to_sym].source_class
#     end

#     def collection?
#       true
#     end

#   end


#   module InstanceMethods
#     def to_param
#       uuid
#     end

#     def set_uuid
#       self.uuid = java.util.UUID.randomUUID.to_s if uuid.blank?
#     end

#     def formatted_created_at
#       I18n.l(created_at)
#     end

#     def formatted_updated_at
#       I18n.l(updated_at)
#     end


#   end


#   def self.included(base)
#     base.extend         ClassMethods
#     base.send :include, InstanceMethods
#     base.send :include, Draper::Decoratable if defined?(::Draper)

#     base.class_eval do
#       property :created_at, type: DateTime
#       property :updated_at, type: DateTime
#       property :uuid,       type: String, index: :exact

#       before_create :set_uuid
#     end
#   end

# end