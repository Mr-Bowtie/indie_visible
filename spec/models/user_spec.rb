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
require 'rails_helper'

RSpec.describe User, type: :model do
  # Factory for creating valid users
  let(:user) { FactoryBot.create(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'is not valid if email is not unique' do
      user_with_same_email = user.dup
      user_with_same_email.email = user.email.upcase
      user_with_same_email.save
      expect(user_with_same_email).not_to be_valid
    end
  end

  describe 'enum roles' do
    it 'can be an author' do
      user.author!
      expect(user.role).to eq('author')
    end

    it 'can be an admin' do
      user.admin!
      expect(user.role).to eq('admin')
    end
  end

  describe 'default role' do
    it 'is set to author by default' do
      new_user = described_class.new
      expect(new_user.role).to eq('author')
    end
  end
end
