Rails.application.routes.draw do
  root to: 'pages#index'

  resources :protocols do 
    member do
      put :favorite
    end
  end

  # TODO follower stats
  resources :users

  resources :relationships, only: [:create, :destroy]
end
