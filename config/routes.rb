Rails.application.routes.draw do
  root 'home#index'

  resources :movies, only: [:index, :show] do
    resources :reviews, only: [:index, :show, :new, :create]
  end
end