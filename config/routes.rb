Rails.application.routes.draw do
  root "entries#index"

  resources :entries, except: [:show]
end
