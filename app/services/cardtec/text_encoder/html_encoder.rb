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
    editable_properties = @text_encoder.to_hash.except(*Cardtec::Node::SYSTEM_PROPERTIES)
    content_tag(:div, id: :cardtec_card_html, class: :cardtec_card) do
      editable_properties.map do |k, v|
        content_tag(:div, class: :cardtec_property) do
          content_tag(:div, k, class: :cardtec_property_name, contenteditable: true) <<
          content_tag(:div, v, class: :cardtec_property_value, contenteditable: true)
        end
      end.join.html_safe
    end
  end

end
