Rails.application.routes.draw do
  root 'modix/nodes#index'
  # root 'raw_node/nodes#index'

  namespace :blog do
    resources :posts do
      get 'by_container/:container', on: :collection, action: :by_container, as: :by_container
    end
  end

  namespace :raw_node do
    resources :nodes do
      get 'by_container/:container', on: :collection, action: :by_container, as: :by_container
    end
  end


  get '/modix', to: redirect('/modix/nodes')
  namespace :modix do
    resources :concepts do
      get 'by_container/:container', on: :collection, action: :by_container, as: :by_container
    end
    resources :things do
      get 'by_container/:container', on: :collection, action: :by_container, as: :by_container
    end
    resources :nodes do
      get 'by_container/:container', on: :collection, action: :by_container, as: :by_container
    end

  end

end
