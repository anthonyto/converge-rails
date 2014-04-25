ConvergeRails::Application.routes.draw do
  # resources :pictures
  
  root to: "events#index"
  
  resources :users

  resources :events do 
    resources :pictures
  end

  namespace :api do 
    resources :events do
      resources :pictures
    end
  end
  
end
