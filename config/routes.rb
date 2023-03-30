Rails.application.routes.draw do
  resources :businesses do
    member do
      get :table_statistics
    end
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
  resources :channels
  resources :goals
  resources :products
  resources :weekly_data_entries
end