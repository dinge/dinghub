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
