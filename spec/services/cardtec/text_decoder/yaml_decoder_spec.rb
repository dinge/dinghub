require 'rails_helper'

RSpec.describe Cardtec::TextDecoder::YamlDecoder do

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

    let(:decoded_to_hash) do
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
        color:   'rot' }
    end


    let(:yaml_decoder) do
      Cardtec::TextDecoder::YamlDecoder.new(encoded_text)
    end


    it { expect(yaml_decoder.to_hash).to match decoded_to_hash }

end