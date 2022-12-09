# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i[index show]
  resources :users do
    member do
      get :followings, :followers
    end
  end
  post 'follows/:id', to: 'follows#create'
  delete 'follows/:id', to: 'follows#destroy'
end
