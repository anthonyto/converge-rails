ConvergeRails::Application.routes.draw do
  resources :pictures

  resources :users

  resources :events do 
    resources :pictures
  end
  namespace :api do 
    resources :events
  end
  
end
