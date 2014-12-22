class Cardtec::TextEncoder::HtmlEncoder
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def initialize(text_encoder)
    @text_encoder = text_encoder
  end

  def to_html
    content_tag(:div, class: :cardtec_card) do
      @text_encoder.to_hash.map do |k, v|
        content_tag(:div, class: :cardtec_property) do
          content_tag(:div, k, class: :cardtec_property_name) <<
          content_tag(:div, v, class: :cardtec_property_value)
        end
      end.join.html_safe
    end
  end

  def to_editable_html
    node_uuid = @text_encoder.neo_node.ctn.uuid
    editable_properties = @text_encoder.to_hash.except(*Cardtec::Node::SYSTEM_PROPERTIES)
    content_tag(:div, id: node_uuid, class: 'cardtec_card cardtec_card_html') do
      editable_properties.map do |k, v|
        content_tag(:div, class: :cardtec_property) do
          content_tag(:div, k, class: :cardtec_property_name, contenteditable: true) <<
          content_tag(:div, v, class: :cardtec_property_value, contenteditable: true, itemprop: k)
        end
      end.join.html_safe
    end
  end

end


# {:title=>"Wunder",
#  :updated_at=>1419008187,
#  :ident=>"maker-concept-1419008186-51369",
#  :created_at=>1419008186,
#  :image=>"wunder.jpg",
#  :uuid=>"fc9f6f79-d339-47c6-9600-d97a6d55a546"}
# [61] pry(main)> Maker::Concept.last.ctn.props