Rails.application.routes.draw do
  resources :businesses
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#dashboard"
  resources :channels
  resources :goals
  resources :products
  resources :weekly_data_entries
end