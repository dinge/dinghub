module NavigationHelper
  def class_to_path(klass)
    klass.to_s.underscore.gsub(/_controller/, '')
  end
end