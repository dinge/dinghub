class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :init_current_actor
  after_action  :empty_current_actor

  def init_current_actor
    Me.current = Me::Actor.first || Me::Actor.create(title: 'system actor')
  end

  def empty_current_actor
    Me.current = nil
  end

end
