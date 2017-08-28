Rails.application.routes.draw do
  root 'home#index'

  get '/about', to: 'home#about', :as => 'about'

  get '/search', to: 'movies#search', :as => 'search'
  get '/discover', to: 'movies#discover', :as => 'discover'

  resources :reviews, only: [:index]

  resources :movies, only: [:index, :show] do
    resources :reviews, only: [:index, :new, :create]
  end

  resources :users, only: [:show]
end