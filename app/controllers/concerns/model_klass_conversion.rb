module ModelKlassConversion
  extend ActiveSupport::Concern

  included do
    helper_method :model_klass_name, :model_klass, :model_klass_name_space
  end


  def model_klass_name
    controller_path.singularize.camelize
  end

  def model_klass
    model_klass_name.constantize
  end

  def model_klass_name_space
    model_klass_name.split('::').first
  end

end