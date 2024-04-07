# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8'
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.6.7'
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'
# Windows does not include zone info files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap'
# Angular style components for views, replacment of sorts for view partials
gem 'view_component'
# Key value database store used most commonly for caching
gem 'redis', '~> 5.0'
# Data access restrictor
gem 'pundit', '~> 2.3'
# Admin panel
gem 'administrate', '~> 0.19.0'
gem 'administrate-field-active_storage'
# user auth
gem 'devise', '~> 4.9'
gem 'devise_invitable'
# Super fast asset compiler with Hot Module Refresh and auto-refresh capabilities on a local dev server
gem 'vite_rails', '~> 3.0'
# css framework
gem 'bulma-rails', '~> 0.9.4'
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'active_storage_validations'
gem 'image_processing', '~> 1.2'
# Google cloud storage adapter
gem 'google-cloud-storage', '~> 1.11', require: false
# seed date genaration
gem 'factory_bot_rails'
# fake data generation
gem 'faker'
# Security scanning 
gem 'brakeman'
# Run security audits on installed gems
gem 'bundler-audit'
# better rails logging
gem 'lograge'
# rubocop extension for rails
gem 'rubocop-rails'
# rubocop extension for rspec
gem 'rubocop-rspec'
# Background job processing
gem 'sidekiq', '>= 7.1.3'
# lightweight pagination
gem 'pagy'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'foreman'
  gem 'pry-byebug'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'
  # add schema annotations to model related files
  gem 'annotate'
  # add a default dockerfile and dockerfile generator for local dev
  gem 'dockerfile-rails', '>= 1.5'
  # Used instead of lsp since I cant find a reliable auto-formatter for erb in nvim
  gem 'erb-formatter', '~> 0.4.3'
  # improves solargraph integration with Rails
  gem 'solargraph-rails'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rspec'
  gem 'rspec-rails'
end


gem "sentry-ruby", "~> 5.13"

gem "sentry-rails", "~> 5.13"

gem 'ransack', '~> 4.1'

gem 'ahoy_matey', '~> 5.1.0'

gem 'blazer', '~> 3.0', '>= 3.0.3'

