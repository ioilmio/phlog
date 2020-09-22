require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:opinions) }
  end
  describe 'validations' do
    it 'expect user to be valid' do
      user = User.create!(
        username: 'user',
        fullname: 'user one',
        email: 'user21@mail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end
    it 'expect user to not be valid' do
      User.create!(
        username: 'user',
        fullname: 'user one',
        email: 'user21@mail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user2 = User.create(
        username: 'user',
        fullname: 'user one',
        email: 'user21@mail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user2).not_to be_valid
    end
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:fullname) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
