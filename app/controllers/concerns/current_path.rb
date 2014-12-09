module CurrentPath
  extend ActiveSupport::Concern

  included do
    helper_method :current_index_path, :current_new_path, :current_show_path, :current_path_for_action, :controller_klass_to_path
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
    klass.to_s.underscore.gsub(/_controller/, '')
  end

end