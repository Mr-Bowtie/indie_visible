require 'sidekiq/web'

Rails.application.routes.draw do
  # ============ Clearance routes =============
  # uncomment to change and override the defaults 

  # resources :passwords, controller: 'clearance/passwords', only: %i[create new]
  # resource :session, controller: 'clearance/sessions', only: [:create]
  #
  # resources :users, controller: 'clearance/users', only: [:create] do
  #   resource :password,
  #            controller: 'clearance/passwords',
  #            only: %i[edit update]
  # end
  #
  # get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  # delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  # get '/sign_up' => 'clearance/users#new', as: 'sign_up'
  # ============= End Clearance routes ===============

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'rails/welcome#index', as: :root

  unless Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == ENV.fetch('SIDEKIQ_WEB_USER') &&
        password == ENV.fetch('SIDEKIQ_WEB_PASSWORD')
    end
  end
  mount Sidekiq::Web => '/sidekiq'
end
