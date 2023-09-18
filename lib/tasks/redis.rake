# frozen_string_literal: true

namespace :redis do
  desc 'Clear out the redis database entirely'
  task reset: :environment do
    if Rails.env.development?
      Sidekiq.redis(&:flushall)
      puts '[ redis:reset ] All redis dbs flushed'
    else
      puts '!!!! You cannot redis:reset outside of development !!!'
    end
  end
end
