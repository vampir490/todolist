Rails.application.routes.draw do
  devise_for :users
  root "entries#index"

  resources :entries, except: [:show]
  resources :users, only: [:edit, :update]

  namespace :api do
    namespace :v1 do
      resources :entries, only: [:index, :create, :update, :destroy]
    end
  end
end
