Rails.application.routes.draw do
  root 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :pictures do
    collection do
      post :confirm
    end
  end
  resources :favorites, only: [:create, :destroy]
  resource :profile,only: %i[show edit update]
end
