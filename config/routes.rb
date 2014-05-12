ConvergeRails::Application.routes.draw do
  apipie
  
  root to: "sessions#welcome"
  
  resources :users, param: :uid, only: [:create] do
    resources :events do 
      get 'download', :action => :download
      resources :pictures
    end
  end

  namespace :api do 
    resources :users, param: :uid, only: [:create] do
      resources :events do 
        post 'invite', :action => :invite
        resources :pictures
      end
    end
  end
  
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  
end
