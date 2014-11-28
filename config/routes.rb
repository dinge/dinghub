Rails.application.routes.draw do
  root 'modix/nodes#index'
  # root 'raw_node/nodes#index'

  namespace :raw_node do
    resources :nodes do
      get 'by_container/:container', on: :collection, action: :by_container, as: :by_container
    end
  end


  get '/modix', to: redirect('/modix/nodes')
  namespace :modix do
    resources :nodes do
      get 'by_container/:container', on: :collection, action: :by_container, as: :by_container
    end
  end

end
