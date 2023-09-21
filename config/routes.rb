require 'sidekiq/web'

Rails.application.routes.draw do
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "books#index"

  unless Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == ENV.fetch('SIDEKIQ_WEB_USER') &&
        password == ENV.fetch('SIDEKIQ_WEB_PASSWORD')
    end
  end
  mount Sidekiq::Web => '/sidekiq'
end
