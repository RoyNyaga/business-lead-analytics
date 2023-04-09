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
  resources :goals do 
    member do
      get :scoreboard_summary
    end

    collection do
      get :form_error_page
    end
  end
  resources :products
  resources :weekly_data_entries do
    collection do
      get :form_error_page
    end
  end
end