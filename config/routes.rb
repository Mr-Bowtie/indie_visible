# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :tags
  get 'series/new'
  post 'series/create'
  get 'books/bulk_activation_toggle_form', to: 'books#bulk_activation_toggle_form'
  get 'users/index'
  get '/search', to: 'search#index'
  get 'authors/:id', to: 'users#author_show'
  get 'heartbeat', to: 'uptime#heartbeat'

  get 'author-spotlight', to: 'users#author_spotlight'

  resources :businesses
  resources :books do
    collection do
      patch :bulk_activation_toggle
    end
  end

  namespace :admin do
    resources :users
    resources :genres
    resources :books
    resources :businesses
    resources :promos
    resources :series
    resources :tags

    root to: 'users#index'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'books#index'

  devise_for :users, skip: :registrations
  as :user do
    # Allow users to edit and delete their own registrations but not create new ones
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users' => 'devise/registrations#update', as: 'user_registration'
    delete 'users' => 'devise/registrations#destroy', as: 'destroy_user_registration'
  end
  unless Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == ENV.fetch('SIDEKIQ_WEB_USER') &&
        password == ENV.fetch('SIDEKIQ_WEB_PASSWORD')
    end
  end
  mount Sidekiq::Web => '/sidekiq'

  mount Blazer::Engine, at: 'blazer'
end
