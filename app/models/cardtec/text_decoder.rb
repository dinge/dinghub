class Cardtec::TextDecoder
  class Object < OpenStruct; end

  cattr_accessor :sample_data

  def initialize(data = nil)
    @data = data || self.class.sample_data
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

  def to_object
    Object.new(to_hash)
  end

  def method_missing(method, *args)
    to_hash[method] || super
  end

end




Cardtec::TextDecoder.sample_data = %q|
labels:   sause_app item
app:      sause
title:    Kerze
ident:    item-44
uuid:     xyz
neo_id:   22

height: 35cm
weight: 240g
color:  rot

facets: physical_object
|
