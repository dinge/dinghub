class Maker::CreatorsController < ApplicationController
  layout false

  def create
    html = params[:cardtec_node][:html]
    d = Mida::Document.new(html)
    @model_klass = d.items.first.flat_properties[:class_name].constantize
    @node = @model_klass.ctn.create_from_html(html)
  end

end
