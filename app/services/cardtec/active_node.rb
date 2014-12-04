module Cardtec::ActiveNode
  extend ActiveSupport::Concern

  included do
    include Neo4j::ActiveNode
    extend ClassMethods

    property  :title,       type: String
    property  :body,        type: String
    property  :image_url,   type: String
    property  :ident,       type: String
    property  :created_at
    property  :updated_at
  end



  module ClassMethods
    def to_cardtec_node
      Cardtec::Node::ActiveNodeClassMethodProxy.new(self)
    end
    alias :ctn :to_cardtec_node
  end



end