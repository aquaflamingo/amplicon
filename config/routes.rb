Rails.application.routes.draw do
  root to: 'pages#index'

  resources :protocols do 
    member do
      put :favorite
    end
  end

  resources :users
end
