class Cardtec::TextEncoder
  DEFAULT_PROPS = [:labels, :app, :title, :ident, :uuid, :neo_id]
  SPECIAL_PROPS = [:neo_id]
  # SPECIAL_PROPS = [:labels, :neo_id]

  def initialize(node)
    @node, @props = node, node.props
  end

  def to_s
    to_hash.map { |p| p.join(' : ') }.join("\n")
  end


  def to_hash
    {}.tap do |props|
      DEFAULT_PROPS.each do |p|
        props[p] =  @props[p] || (p.in?(SPECIAL_PROPS) ? @node.send(p) : nil)
      end
      @props.each { |k, v| props[k] ||= v }
    end
  end

  def raw_dump
    @props.map { |p| p.join(' : ') }.join("\n")
  end

end




# Cardtec::TextEncoder.sample_data = Cardtec::TextDecoder.new.to_hash


# labels:   sause_app item
# app:      sause
# title:    Kerze
# ident:    item-44
# uuid:     xyz
# neo_id:   22

# height: 35cm
# weight: 240g
# color:  rot

# facets: physical_object
