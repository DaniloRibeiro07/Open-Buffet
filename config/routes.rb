Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :buffet_registrations, only: [:new, :create, :edit, :update, :show] do 
    get "search", on: :collection
  end

  resources :event_types, only: [:new, :create, :edit, :update, :show, :destroy] do
    resources :orders, only: [:new, :create]
  end

  get "event_types/:id/image/:image_id", to: "event_types#delete_image"

end
