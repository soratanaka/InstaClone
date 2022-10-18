Rails.application.routes.draw do
  resources :contacts
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
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
