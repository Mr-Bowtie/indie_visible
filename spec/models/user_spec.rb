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
      new_user = User.new
      expect(new_user.role).to eq('author')
    end
  end
end
