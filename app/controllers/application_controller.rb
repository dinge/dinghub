class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ControllerExtensions::PathExtension

  def neo4j_query
    Neo4j::Session.query
  end

end
