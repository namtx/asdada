Rails.application.routes.draw do
  get "categories/index"

  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  get "/carts", to: "carts#index"
  resources :users
  resources :products
  resources :cart, only: :index
  resources :categories
  resources :order_details
end
