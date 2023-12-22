# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")

  get 'help' => 'static_pages#help'
  get 'release_note' => 'static_pages#release_note'
  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'

  resources :users
  resources :scores

  get 'home/:id' => 'users#home', as: 'home'
  get 'home' => 'users#home', as: 'homeb'
  root 'sessions#new'
end
