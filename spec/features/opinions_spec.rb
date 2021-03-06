require 'rails_helper'

RSpec.describe 'Create an opinion', type: :feature, js: true do
  scenario 'with valid inputs' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_button 'Sign up'
    sleep 1
    fill_in 'opinion_content', with: 'opinion test'
    click_on 'Create Opinion'
    sleep 1
    expect(page).to have_content('opinion test')
  end
  scenario 'cant create opinion' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_button 'Sign up'
    sleep 1
    fill_in 'opinion_content', with: ''
    click_on 'Create Opinion'
    sleep 1
    raise_error 'Content can\'t be blank'
  end
end
