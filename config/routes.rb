Rails.application.routes.draw do
  root 'raw_node/nodes#index'

  namespace :raw_node do
    resources :nodes do
      get 'by_label/:label', on: :collection, action: :by_label, as: :by_label
    end
  end


  get '/modix', to: redirect('/modix/nodes')
  namespace :modix do
    resources :nodes do
      get 'by_container/:label', on: :collection, action: :by_container, as: :by_container
    end
  end


end
