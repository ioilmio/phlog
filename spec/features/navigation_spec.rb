require 'rails_helper'

RSpec.describe 'User navigation', type: :feature, js: true do
  scenario 'can log in after sign up' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_button 'Sign up'
    sleep 1
    click_on 'Log out'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    click_on 'Log in'
    expect(page).to have_content('test user')
  end
  scenario 'can edit his own profile' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_button 'Sign up'
    sleep 1
    click_on 'Settings'
    expect(page).to have_content('Edit your profile')
    fill_in 'user_name', with: 'new username'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_on 'Save changes'
    expect(page).to have_content('new username')
    sleep 1
  end
  scenario 'can create new opinion on new opinion page' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_on 'Sign up'
    click_on 'New Opinion'
    sleep 1
    expect(page).to have_content('Write something')
  end
  scenario 'can visit his own profile' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_on 'Sign up'
    click_on 'Hello,test user'
    sleep 1
    expect(page).to have_content('test user')
  end
  scenario 'can visit users profiles' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_on 'Sign up'
    click_on 'Log out'
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user2'
    fill_in 'user_fullname', with: 'test user2'
    fill_in 'user_email', with: 'test2@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_on 'Sign up'
    click_on 'test user2'
    sleep 1
    expect(page).to have_content('test user2')
  end
end
