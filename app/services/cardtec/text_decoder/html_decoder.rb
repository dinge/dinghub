class Cardtec::TextDecoder::HtmlDecoder

  def initialize(data)
    @data = data
  end

  def to_hash
    props = {}
    Nokogiri::HTML.fragment(data).css('.cardtec_property').each do |property|
      property_name = property.css('.cardtec_property_name').first.text.presence
      property_value = property.css('.cardtec_property_value').first.text.presence
      props[property_name] = property_value if property_name
    end
    props.with_indifferent_access
  end


end