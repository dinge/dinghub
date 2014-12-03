class Cardtec::TextDecoder::YamlDecoder

  def initialize(data)
    @data = data
  end

  def to_hash
    YAML.parse(@data).to_ruby.with_indifferent_access
  end

end