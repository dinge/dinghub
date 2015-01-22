source 'https://rubygems.org'

gem 'rails'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',     group: :doc
gem 'bcrypt', '~> 3.1.7'
gem 'foundation-rails'
gem 'compass-rails'
gem 'neo4j', git: 'git@github.com:neo4jrb/neo4j.git'
gem 'haml-rails'
gem 'simple_form'
gem 'font-awesome-rails'
gem 'nokogiri'
gem 'thin'  if !Dir.glob('./config/thin/*').empty?
gem 'browser'
gem 'configatron', require: false
gem 'wisper'
# gem 'wisper-activejob'
# gem 'actor_bot_adapters', git: 'git@github.com:megorei/actor_bot_adapters.git'
# gem 'spawno', github: 'megorei/spawno'
gem 'jquery-ui-rails'

gem 'carrierwave-neo4j'
gem 'kaminari', github: 'dpisarewski/kaminari', branch: 'neo4j'

gem 'patron'
gem 'mini_magick'
gem 'mida'
gem 'andand'

gem 'rdf-rdfa'
gem 'rdf-microdata'

group :development do
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-thin' if !Dir.glob('./config/thin/*').empty?
  gem 'quiet_assets'
end

group :test, :development do
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
  # gem 'spring'
end
