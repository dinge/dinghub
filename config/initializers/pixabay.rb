# PixabayClient.configure do |c|
#   c.username  = Rails.application.secrets.pixabay["key"]
#   c.key       = Rails.application.secrets.pixabay["secret"]
# end



# module ActorBotAdapters
#   class Railtie < Rails::Railtie
#     initializer 'actor_bot_adapters.configure_rails_initialization' do |app|
#       Config.setup(app.root.join('config', 'actor_bot_adapters.yml'))
#       Config.settings['secrets'] = app.secrets
#       ActorBotAdapters.setup
#     end
#   end
# end


# require 'yaml'

# module ActorBotAdapters
#   class Configuration
#     attr_accessor :settings

#     def initialize
#       self.settings = {}
#     end

#     def load_from_file(path)
#       self.settings.merge! YAML.load_file(path)
#     end

#     def setup(path = nil)
#       load_from_file(path) if path
#     end

#     def method_missing(method_name)
#       settings[method_name.to_s]
#     end
#   end

#   Config = Configuration.new
# end

