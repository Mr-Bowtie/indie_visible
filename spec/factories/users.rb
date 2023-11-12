# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  about                  :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("author")
#  social_links           :string           default([]), is an Array
#  website_url            :string
#  invited_by_id          :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    name { Faker::Name.name }
  end

  trait :is_author do
    role { 'author' }
    about { Faker::Lorem.paragraphs(number: rand(2..10)).join(' ') }
    website_url { Faker::Internet.url }
    facebook_url { Faker::Internet.url }
    instagram_url { Faker::Internet.url }
    tiktok_url { Faker::Internet.url }

    after(:build) do |book|
      book.photo.attach(
        io: File.open(Rails.root.join('public/user_image1.png')),
        filename: 'user_image_placeholder.png',
        content_type: 'image/png'
      )
    end
  end
end
