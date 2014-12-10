class Cardtec::TextEncoder
  attr_reader :neo_node, :props

  def initialize(neo_node, cardtec_node)
    @neo_node, @props = neo_node, neo_node.props
    @cardtec_node = cardtec_node
  end


  def to_param
    neo_node.neo_id
  end

  def to_s
    to_hash.stringify_keys.to_yaml
  end

  alias :to_yaml :to_s

  def to_json
    to_hash.stringify_keys.to_json
  end

  def to_html
    HtmlEncoder.new(self).to_html
  end

  def to_editable_html
    HtmlEncoder.new(self).to_editable_html
  end

  def to_hash
    {}.tap do |props|
      all_property_names.each do |p|
        props[p] = @props[p] || (neo_node.respond_to?(p) ? (neo_node.send(p) rescue nil) : nil)
      end
      @props.each { |k, v| props[k] ||= v }
    end
  end

  def all_property_names
    ( Cardtec::Node::PROPERTIES +
      (@cardtec_node.neo_ruby_klass ? @cardtec_node.neo_ruby_klass.attribute_names.map(&:to_sym) : []) ).uniq
  end

  def raw_dump
    neo_node.to_yaml
  end

end