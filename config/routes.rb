Rails.application.routes.draw do
  root to: 'pages#index'

  resources :protocols
  resources :users
end
