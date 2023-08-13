require "sidekiq/web"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  if !Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == ENV.fetch("SIDEKIQ_WEB_USER") &&
        password == ENV.fetch("SIDEKIQ_WEB_PASSWORD")
    end
  end
  mount Sidekiq::Web => "/sidekiq"end
