class Cardtec::Node

  attr_reader :neo_node

  SYSTEM_PROPERTIES =
    [ :labels,
      :neo_id,
      :app,
      :uuid,
      :created_at,
      :updated_at,
      :_classname ]


  def initialize(neo_node)
    @neo_node = neo_node
  end

  def to_yaml
    Cardtec::TextEncoder.new(neo_node).to_yaml
  end

  def to_html
    Cardtec::TextEncoder.new(neo_node).to_html
  end

  def to_editable_html
    Cardtec::TextEncoder.new(neo_node).to_editable_html
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


  def self.from_yaml(yaml)
    Cardtec::YamlDecoder.new(yaml).from_yaml
  end

  def self.create_from_yaml(yaml)
    new_props = Cardtec::TextDecoder::YamlDecoder.new(yaml).to_hash
    labels = new_props.delete(:labels)
    neo_id = new_props.delete(:neo_id)
    Neo4j::Node.create(new_props, *labels).to_cardtec_node
  end

  def self.create_from_html(html)
    new_props = Cardtec::TextDecoder::HtmlDecoder.new(html).to_hash
    labels = new_props.delete(:labels)
    neo_id = new_props.delete(:neo_id)
    Neo4j::Node.create(new_props, *labels).to_cardtec_node
  end

  def to_param
    neo_node.neo_id
  end

  def method_missing(method, *args)
    neo_node.send(method, *args)
  end

end