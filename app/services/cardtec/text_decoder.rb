class Cardtec::TextDecoder

  # attr_reader :text

  def initialize(cardtec_node)
    @cardtec_node = cardtec_node
  end

  # def to_json
  #   to_hash.to_json
  # end

  # def to_a
  #   @data.split(/\n/,).select(&:present?).map { |r| r.split(/:/).map(&:strip) }
  # end

  # def to_hash
  #   HashWithIndifferentAccess.new(Hash[to_a])
  # end

  def to_hash
    @hash
  end

  def from_yaml(data)
    @hash = YamlDecoder.new(data).to_hash
    self
  end

  def from_html(data)
    @hash = HtmlDecoder.new(data).to_hash
    self
  end


  # def keys
  #   to_hash.keys.map(&:to_sym)
  # end

  # def values
  #   to_hash.values
  # end

  # def to_value_object
  #   ValueObject.new(to_hash)
  # end

  # def method_missing(method, *args)
  #   to_hash[method] || super
  # end

end