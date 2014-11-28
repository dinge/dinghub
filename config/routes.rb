Rails.application.routes.draw do
  root 'noodle/nodes#index'

  namespace :noodle do
    resources :nodes do
      get 'by_label/:label', on: :collection, action: :by_label, as: :by_label
    end
  end

  namespace :modix do
    resources :nodes do
      get 'by_label/:label', on: :collection, action: :by_label, as: :by_label
    end
  end


end
