Rails.application.routes.draw do
  root 'home#index'

  get '/search', to: 'movies#search'

  resources :reviews, only: [:index]

  resources :movies, only: [:index, :show] do
    resources :reviews, only: [:index, :show, :new, :create]
  end

  resources :users, only: [:show]
end