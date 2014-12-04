class Blog::Post < Blog


end



# class Cardtec::Node::ClassMethodsProxy
#   include Cardtec::Node::ClassMethods

# end







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