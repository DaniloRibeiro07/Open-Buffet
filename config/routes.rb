Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  namespace :api do 
    namespace :v1 do 

      resources :buffet_registrations, only: [:index, :show] do 
        resources :event_types, only: [:index]
      end

      resources :event_types, only: [] do 
        resources :orders, only: [:create]
      end
      
    end
  end

  resources :buffet_registrations, only: [:new, :create, :edit, :update, :show] do 
    get "search", on: :collection
  end

  resources :event_types, only: [:new, :create, :edit, :update, :show, :destroy] do
    post "desactive", on: :member
    post "active", on: :member
    resources :orders, only: [:new, :create, :edit, :update]
  end

  resources :orders, only: [:show, :index] do 
    post 'cancel', on: :member
    patch 'set_final_value', on: :member
    post 'confirm', on: :member
    post 'send_message', on: :member
  end

  get "event_types/:id/image/:image_id", to: "event_types#delete_image"

end
