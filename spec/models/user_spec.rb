require 'rails_helper'
require 'database_cleaner/active_record'
DatabaseCleaner.strategy = :truncation

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
    # it { should validate_uniqueness_of(:email).case_insensitive }
  end
  DatabaseCleaner.clean

  it 'should follow user' do
    user = User.create!(
      username: 'user',
      fullname: 'user one',
      email: 'user@mail.com',
      password: 'password',
      password_confirmation: 'password'
    )
    user2 = User.create!(
      username: 'user',
      fullname: 'user one',
      email: 'user2@mail.com',
      password: 'password',
      password_confirmation: 'password'
    )
    user.follow(user2)
    expect(user.following.count).to eq(1)
    expect(user.following?(user2)).to be_truthy
  end
  DatabaseCleaner.clean

  user = User.create!(
    username: 'user',
    fullname: 'user one',
    email: 'user111@mail.com',
    password: 'password',
    password_confirmation: 'password'
  )
  user2 = User.create!(
    username: 'user',
    fullname: 'user one',
    email: 'user100@mail.com',
    password: 'password',
    password_confirmation: 'password'
  )
  it 'unfollow user' do
    user.unfollow(user2)
    expect(user.following.count).to eq(0)
    expect(user.following?(user2)).to be_falsy
  end
end
