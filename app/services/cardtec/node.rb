class Cardtec::Node
  extend  Cardtec::Node::Creater
  include Cardtec::Node::Updater
  include Wisper::Publisher

  attr_reader :neo_node, :neo_ruby_klass

  PROPERTIES =
    [ :labels,
      :neo_id,
      :ident,
      :title,
      :uuid,
      :body,
      :image_url,
      :created_at,
      :updated_at,
      :_classname ]


  SYSTEM_PROPERTIES =
    [ :labels,
      :neo_id,
      :uuid,
      :created_at,
      :updated_at,
      :_classname ]

  PROPERTIES_TO_KEEP = PROPERTIES# - [:updated_at, :created_at]


  delegate :to_yaml, :to_html, :to_param, :to_editable_html, :to_hash, :to_json, to: :text_encoder_instance
  delegate :from_yaml, :from_html, to: :text_decoder_instance


  def initialize(neo_node = NullNode.new, neo_ruby_klass = nil)
    @neo_node, @neo_ruby_klass = neo_node, neo_ruby_klass
  end


  def human_title
    title rescue neo_id
  end


  def text_encoder_instance
    Cardtec::TextEncoder.new(neo_node, self)
  end

  def text_decoder_instance
    Cardtec::TextDecoder.new(self)
  end


  def notify_to_after_save_listeners
    broadcast(:node_saved, self, Me.current)
  end


  def method_missing(method, *args)
    if neo_node.props.has_key?(method)
      neo_node.props[method]
    else
      neo_node.send(method, *args)
    end
  end

end