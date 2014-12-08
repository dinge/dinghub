class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :init_current_actor
  after_filter  :empty_current_actor

  def init_current_actor
    Me.current = Me::Actor.first
  end

  def empty_current_actor
    Me.current = nil
  end

end
