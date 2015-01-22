class Cardtec::TextEncoder::HtmlEncoder
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def initialize(text_encoder)
    @text_encoder = text_encoder
    @active_node = text_encoder.cardtec_node.active_node
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

  def to_card_element_properties(options = {})
    # class:      ActionView::RecordIdentifier.dom_class(@active_node, :card)
      # itemtype:   "#{Dinghub.setup.semantic_schema.root_url}/Thing",

    { itemscope:  '',
      itemtype:   'http://asdasd/Thing',
      itemid:     @active_node.uuid,
      itemtype:   @active_node.class.schema_path }.merge(options)
  end

end
