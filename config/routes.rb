Rails.application.routes.draw do
  root 'maker/concepts#index'

  concern :filterable do
    get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    get :search, on: :collection, action: :search, as: :search
  end


  namespace :raw_node do
    root 'nodes#index'
    resources :nodes, concerns: [:filterable]
  end


  namespace :me do
    root 'actors#index'
    resources :actors, concerns: [:filterable]
    resources :contributions, concerns: [:filterable]
  end

  namespace :maker do
    root 'concepts#index'

    resource :creator, only: [:create]
    resource :editors, only: [:create]
    resources :mixers, only: [:create] do
      get :related_nodes, action: :related_nodes, on: :member
      get 'relationships_between/:last_node_id', action: :relationships_between
    end


    resources :topics, concerns: [:filterable]
    resources :concepts, concerns: [:filterable]
    resources :traits, concerns: [:filterable]
    resources :skills, concerns: [:filterable]
    resources :bundles, concerns: [:filterable]
    resources :items, concerns: [:filterable]
    resources :trait_values, concerns: [:filterable]
  end


  namespace :blog do
    root 'posts#index'
    resources :posts, concerns: [:filterable]
  end


end
