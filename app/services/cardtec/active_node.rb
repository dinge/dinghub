module Cardtec::ActiveNode
  extend  ActiveSupport::Concern

  included do
    include Neo4j::ActiveNode
    include GlobalID::Identification
    include Wisper::Publisher
    include Neo4jrb::Paperclip
    # extend  CarrierWave::Neo4j
    extend  ClassMethods


    property  :title,       type: String
    property  :body,        type: String
    property  :image_url,   type: String
    property  :ident,       type: String
    property  :created_at
    property  :updated_at


    has_neo4jrb_attached_file         :image, styles: { small: '200x' }
    validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
    # mount_uploader :image, ImageUploader

    delegate :relationship_methods, :association_methods, :core_relationship_types, to: :class

    before_create  :set_ident
    after_save     :notify_to_after_save_listeners
  end



  def to_cardtec_node
    node = persisted? ? neo4j_obj : Cardtec::Node::NullNode.new
    @cardtec_node ||= Cardtec::Node.new(node, self.class)
  end
  alias :ctn :to_cardtec_node


  def neo4j_query
    Neo4j::Session.query
  end


  def all_related_nodes
    data_arrays = association_methods.map do |m|
      value = send(m)
      value.try(:to_a) || [value]
    end
    Struct.new(*association_methods).new(*data_arrays)
  end

  # ....
  # def all_related_nodes
  #   related_nodes_matchers = self.class.associations.values.map.with_index
  #   return_columns = association_methods

  #   q = neo4j_query.match(n: self.class.name).where(n: { neo_id: neo_id })
  #   related_nodes_matchers.each do |a, i|
  #    q = q.break.optional_match("(n)-[r#{i}:#{a.relationship_type}]-(#{a.name})")
  #   end
  #   q = q.return(*[:n, return_columns])
  #   prepare_results(q)
  # end

  # def prepare_results(query)
  #   columns = query.response.columns.map(&:to_sym)
  #   Struct.new(*columns).new(*columns.map { |c| query.map(&c).compact.uniq })
  # end

  def set_ident
    self.ident = ident_format
  end

  def ident_format
    [self.class, human_title, Time.now.utc.to_f].join('_').parameterize('_')
  end

  def notify_to_after_save_listeners
    broadcast(:node_saved, self, Me.current)
  end


  def human_title
    ctn.title rescue neo_id
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

    def name_without_namespace
      name.split('::').last
    end

  end

end


  # def all_related_nodes
  #   # replace with with cypher query
  #   Struct.new(*association_methods).new(*association_methods.map { |m| send(m).to_a } )
  # end

 # Maker::Concept.first.toast.send(:clauses).select{|c| c.is_a?(Neo4j::Core::QueryClauses::ReturnClause)}.map{|c| c.instance_variable_get(:@arg) }

  # def toast
  #   q = neo4j_query.match(n: self.class.name).where(n: { neo_id: neo_id })
  #   self.class.associations.values.map.with_index do |a, i|
  #    q = q.break.optional_match("(n)-[r#{i}:#{a.relationship_type}]-(#{a.name})")
  #   end
  #   q.return(*[:n, association_methods])
  # end

  # def toast
  #   key = self.class.name_without_namespace.downcase.to_sym
  #   q = neo4j_query.match({key => self.class.name})
  #   self.class.associations.values.map.with_index do |a, i|
  #    q = q.break.optional_match("(#{key})-[r#{i}:#{a.relationship_type}]-(#{a.name})")
  #   end
  #   q = q.where("ID(#{key}) = {neo_id}")
  #   q.return(*[key,association_methods].flatten).params(neo_id: neo_id)
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