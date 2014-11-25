Rails.application.routes.draw do
  root 'hashgrid/players#show'

  namespace :hashgrid do
    resource :player
    resources :nodes do
      get 'by_label/:label', on: :collection, action: :by_label, as: :by_label
    end
    resources :node_controls
    resources :labels
  end

end
