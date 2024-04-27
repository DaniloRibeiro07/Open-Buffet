Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :buffet_registrations, only: [:new, :create, :edit, :update, :show] do 
    get "search", on: :collection
  end
  resources :event_types, only: [:new, :create, :edit, :update, :show, :destroy]
end
