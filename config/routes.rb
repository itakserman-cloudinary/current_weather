Rails.application.routes.draw do
  root "users#index"
  
  resources :users do
    resources :user_location_settings
  end
  
  resources :locations
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end