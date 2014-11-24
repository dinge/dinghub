class Cardtec::TextDecoder::YamlDecoder < Cardtec::TextDecoder

  def to_hash
    YAML.parse(data).to_ruby.with_indifferent_access
  end

end