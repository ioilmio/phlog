require 'rails_helper'

RSpec.describe 'Create a user', type: :feature do
  scenario 'with valid inputs' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_button 'Sign up'

    expect(page).to have_content('test user')
  end
  scenario 'blank email' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: ''
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_button 'Sign up'

    raise_error 'Email can\'t be blank'
  end
  scenario 'short password' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test'
    fill_in 'user_password_confirmation', with: 'test'
    click_button 'Sign up'

    raise_error 'Password must be at least 8 characters'
  end
  scenario 'password dont match' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'testpassword'
    fill_in 'user_password_confirmation', with: 'testpazzword'
    click_button 'Sign up'

    raise_error 'Password don\'t match'
  end
  scenario 'can log in after sign up' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_button 'Sign up'

    click_on 'logout-icon'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    click_on 'Log in'
    expect(page).to have_content('test user')
  end
  scenario 'can log in after sign up' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_button 'Sign up'

    click_on 'Settings'
    expect(page).to have_content('Edit your profile')
  end
  scenario 'can create new opinion' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_on 'Sign up'
    click_on 'new-opi-icon'

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
    click_on 'test user'
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
    click_on 'Sign up'
    click_on 'logout-icon'
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user2'
    fill_in 'user_fullname', with: 'test user2'
    fill_in 'user_email', with: 'test2@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_on 'Sign up'
    click_on 'test user2'

    expect(page).to have_content('test user2')
  end
  scenario 'can visit follower page' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_on 'Sign up'
    click_on 'Follower'

    expect(page).to have_content('Follower')
  end
  scenario 'can visit following page' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_username', with: 'test user'
    fill_in 'user_fullname', with: 'test user'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test password'
    fill_in 'user_password_confirmation', with: 'test password'
    click_on 'Sign up'
    click_on 'Following'

    expect(page).to have_content('Following')
  end
end
