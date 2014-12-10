require 'rails_helper'
require 'support/node_mock'

RSpec.describe Cardtec::TextEncoder do
  let(:node) { NodeMock.new }

  it { expect(node.neo_id).to eql 22 }


  describe 'encoding to text' do
    let(:text_encoder) { Cardtec::TextEncoder.new(node, Cardtec::Node.new(node)) }

    let(:encoded_text) do
      text = <<-TEXT
---
labels:
- :Item
neo_id: 22
ident: item-44
title: Kerze
uuid: xyz
body: ist aus Wachs
image_url: http://image.url
created_at: '2014-11-24T13:11:22+00:00'
updated_at: '2014-11-24T13:11:22+00:00'
_classname: Bang
height: 35
weight: 240
color: rot
TEXT
    end

    let(:decoded_with_yaml) do
      { labels:   [:Item],
        neo_id:   22,

        ident:    'item-44',
        title:    'Kerze',
        uuid:     'xyz',
        body:     'ist aus Wachs',

        image_url: 'http://image.url',
        created_at: '2014-11-24T13:11:22+00:00',
        updated_at: '2014-11-24T13:11:22+00:00',
        _classname: 'Bang',

        height:   35,
        weight:   240,
        color:   'rot' }.with_indifferent_access
    end


    it { expect(text_encoder.to_yaml).to eql encoded_text }
    it { expect(YAML.parse(encoded_text).to_ruby).to match decoded_with_yaml }

  end

end