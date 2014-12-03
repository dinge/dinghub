set :branch, 'master'
set :rack_env, 'production'
set :rails_env, 'production'

set :repo_url, 'git@github.com:jhmegorei/dinghub.git'

server '134.119.24.49', user: 'live', port: 22, roles: %w{web app db}
