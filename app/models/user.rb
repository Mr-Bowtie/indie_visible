# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  about                  :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  facebook_url           :string
#  instagram_url          :string
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
#  spotlight              :boolean
#  tiktok_url             :string
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
class User < ApplicationRecord
  PROMO_REQUIRED_ATTRIBUTES = %i[name email about]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { author: 0, admin: 1, super_admin: 2 }
  has_many :books, foreign_key: 'author_id'
  has_many :series, dependent: :destroy
  has_one_attached :photo

  # authors that have been sent invitations but havent logged in and filled out their profile will have an empty name
  scope :valid_authors, -> { where(name: '').invert_where }
  scope :in_the_spotlight, -> { where(spotlight: true) }

  def at_least_admin?
    admin? || super_admin?
  end

  def profile_created?
    PROMO_REQUIRED_ATTRIBUTES.all? { |attr| send(attr).present? } &&
    photo.attached?
  end
  def self.ransackable_attributes(_auth_object = nil)
    ['name']
  end
end
