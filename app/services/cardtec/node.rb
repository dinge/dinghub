class Cardtec::Node

  attr_reader :neo_node, :neo_ruby_klass

  SYSTEM_PROPERTIES =
    [ :labels,
      :neo_id,
      :app,
      :uuid,
      :created_at,
      :updated_at,
      :_classname ]


  delegate :to_yaml, :to_html, :to_editable_html, :to_hash, :to_json, to: :text_encoder_instance


  def initialize(neo_node = NullNode.new, neo_ruby_klass = nil)
    @neo_node, @neo_ruby_klass = neo_node, neo_ruby_klass
  end


  def text_encoder_instance
    Cardtec::TextEncoder.new(neo_node, self)
  end


  def to_param
    neo_node.neo_id
  end



  def update_from_yaml(yaml)
    update_from_hash(Cardtec::TextDecoder::YamlDecoder.new(yaml).to_hash)
  end

  def update_from_html(html)
    update_from_hash(Cardtec::TextDecoder::HtmlDecoder.new(html).to_hash)
  end

  def update_from_hash(new_props)
    labels = new_props.delete(:labels)
    neo_id = new_props.delete(:neo_id)

    neo_node.props = new_props
    neo_node.set_label(*labels) if labels.present?
    neo_node.to_cardtec_node
  end


  def method_missing(method, *args)
    if neo_node.props.has_key?(method)
      neo_node.props[method]
    else
      neo_node.send(method, *args)
    end
  end



  class << self
    def create_from_yaml(yaml)
      create_from_hash(Cardtec::TextDecoder::YamlDecoder.new(yaml).to_hash)
    end

    def create_from_html(html)
      create_from_hash(Cardtec::TextDecoder::HtmlDecoder.new(html).to_hash)
    end

    def create_from_hash(new_props)
      labels = new_props.delete(:labels)
      neo_id = new_props.delete(:neo_id)
      Neo4j::Node.create(new_props, *labels)
    end
  end



  class NullNode < OpenStruct
    def props
      {}
    end

    def to_cardtec_node
      @cardtec_node ||= Cardtec::Node.new(self)
    end
    alias :ctn :to_cardtec_node
  end

end