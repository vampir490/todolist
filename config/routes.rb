Rails.application.routes.draw do
  devise_for :users
  root "entries#index"

  resources :entries, except: [:show]
  resources :users, only: [:edit, :update]
end
