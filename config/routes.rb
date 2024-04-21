Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :buffet_registrations, only: [:new, :create, :edit, :update, :show]
  resources :event_types, only: [:new, :create, :edit, :update, :show, :destroy]
end
