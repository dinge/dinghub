Rails.application.routes.draw do
  root 'welcome#index'

  namespace :hashgrid do
    resources :nodes
  end

end
