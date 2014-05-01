ConvergeRails::Application.routes.draw do
  # resources :pictures
  
  root to: "events#index"
  # root to: "sessions#welcome"
  
  resources :users

  resources :events do 
    resources :pictures
  end

  namespace :api do 
    resources :events do
      resources :pictures
    end
  end
  
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  
end
