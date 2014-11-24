require 'rails_helper'


class NodeMock
  def labels
    [:Item]
  end

  def neo_id
    22
  end

  def props
    { app:      'sause',
      title:    'Kerze',
      ident:    'item-44',
      uuid:     'xyz',

      image_url: 'http://image.url',
      created_at: DateTime.parse('2014-11-24 13:11:22').to_s,
      updated_at: DateTime.parse('2014-11-24 13:11:22').to_s,

      height:   35,
      weight:   240,
      color:    'rot' }
  end

  def method_missing(method, *args)
    props[method] if props.has_key?(method)
  end
end




RSpec.describe Cardtec::TextEncoder do
  let(:node) { NodeMock.new }

  it { expect(node.neo_id).to eql 22 }


  describe 'encoding to text' do
    let(:text_encoder) { Cardtec::TextEncoder.new(node) }

    let(:encoded_text) do
      text = <<-TEXT
---
labels:
- :Item
neo_id: 22
app: sause
title: Kerze
ident: item-44
uuid: xyz
image_url: http://image.url
created_at: '2014-11-24T13:11:22+00:00'
updated_at: '2014-11-24T13:11:22+00:00'
height: 35
weight: 240
color: rot
      TEXT
    end

    let(:decoded_with_yaml) do

      { labels:   [:Item],
        neo_id:   22,

        app:      'sause',
        title:    'Kerze',
        ident:    'item-44',
        uuid:     'xyz',

        image_url: 'http://image.url',
        created_at: '2014-11-24T13:11:22+00:00',
        updated_at: '2014-11-24T13:11:22+00:00',

        height:   35,
        weight:   240,
        color:   'rot' }.with_indifferent_access
    end


    it { expect(text_encoder.to_s).to eql encoded_text }
    it { expect(YAML.parse(encoded_text).to_ruby).to eql decoded_with_yaml }

  end

end