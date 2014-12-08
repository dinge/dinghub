Rails.application.routes.draw do
  root 'modix/concepts#index'

  namespace :raw_node do
    resources :nodes do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
  end


  get '/me', to: redirect('/me/actors')
  namespace :me do
    resources :actors do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
    resources :contributions do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
  end


  get '/maker', to: redirect('/maker/concepts')
  namespace :maker do
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




  get '/modix', to: redirect('/modix/concepts')
  namespace :modix do
    resources :concepts do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
    resources :things do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
  end

  get '/blog', to: redirect('/blog/posts')
  namespace :blog do
    resources :posts do
      get 'filtered/:filter', on: :collection, action: :filtered, as: :filtered
    end
  end


end
