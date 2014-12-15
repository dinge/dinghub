module CurrentPath
  extend ActiveSupport::Concern

  included do
    helper_method :current_index_path, :current_new_path, :current_show_path,
                  :current_path_for_action, :controller_klass_to_path, :controller_path_to_dom_class
  end

  def current_index_path
    '/' + controller_path
  end

  def current_new_path
    current_path_for_action(:new)
  end

  def current_show_path(id)
    current_path_for_action(nil, id)
  end

  def current_path_for_action(action, id = nil, params = {})
    id = neo_node_to_param(id) if id.respond_to?(:neo_id)
    [current_index_path, action, id].compact.join('/')
  end

  def controller_klass_to_path(klass)
    klass.name.underscore.gsub(/_controller/, '')
  end

  def controller_path_to_dom_class(klass)
    klass.name.gsub(/Controller$/, '').parameterize('_').singularize
  end

  # def show_node_path(node)
  #   node.class.name.pluralize.parameterize('_') << '_path'
  # end

end