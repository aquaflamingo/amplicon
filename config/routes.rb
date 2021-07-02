Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: "protocols#index", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'pages#index'
  end

  resources :protocols do 
    member do
      put :favorite
    end
  end

  # TODO follower stats
  resources :users

  resources :relationships, only: [:create, :destroy]
end
