Rails.application.routes.draw do
  root to: 'pages#index'
  resources :repositories
end
