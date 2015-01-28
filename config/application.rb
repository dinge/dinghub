require File.expand_path('../boot', __FILE__)

require 'active_model/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'neo4j/railtie'

require 'configatron/core'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dinghub
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Berlin'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.generators do |g|
      g.orm :neo4j
    end


    config.neo4j.session_type = :server_db
    config.neo4j.session_path = 'http://localhost:7474'
    config.neo4j.transform_rel_type = :upcase

    config.autoload_paths += %W(#{config.root}/app)


    app_config = config.app_config = Configatron::RootStore.new
    app_config.semantic_schema.root_url = 'http://dingdealer.de/'


  end
end


module AppConfig
  def self.config
    Rails.application.config.app_config
  end
end
