Rails.application.routes.draw do
  get "categories/index"

  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  get "/carts", to: "carts#index"
  post "/carts", to: "carts#create"
  put "/carts", to: "carts#update"
  delete "/carts", to: "carts#destroy"
  resources :users do
    resources :suggested_products
    resources :orders, only: [:show]
  end
  resources :products do
    resources :ratings
  end
  resources :cart, only: :index
  resources :categories
  resources :orders
  resources :order_confirmations, only: [:edit]
  namespace :admin do
    resources :products do
      collection {post :import}
    end
    resources :users, only: [:index, :destroy]
    resources :orders
  end
end
