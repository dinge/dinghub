module ControllerExtensions::PathExtension
  extend ActiveSupport::Concern

  included do
    helper_method :current_index_path, :current_new_path, :current_show_path, :current_path_for_action
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
    [current_index_path, action, id.to_param.presence].compact.join('/')
  end

end