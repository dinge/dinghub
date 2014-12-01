class Cardtec::TextEncoder

  attr_reader :node, :props

  PROPS =
    [ :labels,
      :neo_id,
      :app,
      :title,
      :ident,
      :uuid,
      :image_url,
      :created_at,
      :updated_at ]

  def initialize(node)
    @node, @props = node, node.props
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
      PROPS.each do |p|
        props[p] = @props[p] || (@node.respond_to?(p) ? @node.send(p) : nil)
      end
      @props.each { |k, v| props[k] ||= v }
    end
  end

  def raw_dump
    @node.to_yaml
  end

end



=begin # ouput
---
labels:
- :Item
neo_id: 22
app: sause
title: Kerze
ident: item-44
uuid: xyz
color: rot
height: 35
weight: 240

=end