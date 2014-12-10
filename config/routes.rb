Rails.application.routes.draw do
  root 'maker/concepts#index'

  namespace :raw_node do
    root 'nodes#index'
    resources :nodes do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
  end


  namespace :me do
    root 'actors#index'
    resources :actors do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
    resources :contributions do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
  end

  namespace :maker do
    root 'concepts#index'
    resources :topics do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
    resources :concepts do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
    resources :traits do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
    resources :skills do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
    resources :bundles do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
    resources :items do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
    resources :trait_values do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
  end


  namespace :blog do
    root 'posts#index'
    resources :posts do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
  end


end
