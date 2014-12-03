class Cardtec::TextDecoder::HtmlDecoder

  def initialize(data)
    @data = data
  end

  def to_hash
    props = {}
    Nokogiri::HTML.fragment(@data).elements.to_a.in_groups_of(2).map do |e|
      props[e.first.text] = e.last.text.presence
    end
    props.with_indifferent_access
  end


end