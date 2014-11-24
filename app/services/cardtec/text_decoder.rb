class Cardtec::TextDecoder
  class ValueObject < OpenStruct; end

  attr_reader :data

  def initialize(data = nil)
    @data = data
  end

  def to_json
    to_hash.to_json
  end

  def to_a
    @data.split(/\n/,).select(&:present?).map { |r| r.split(/:/).map(&:strip) }
  end

  def to_hash
    HashWithIndifferentAccess.new(Hash[to_a])
  end

  def keys
    to_hash.keys.map(&:to_sym)
  end

  def values
    to_hash.values
  end

  def to_value_object
    ValueObject.new(to_hash)
  end

  def method_missing(method, *args)
    to_hash[method] || super
  end

end