require 'rails_helper'

describe 'the registration process', type: :feature do
  it 'fills in valid information in the form' do
    visit root_path
    expect(page).to have_content('Log In')

    click_link 'Register'
    expect(page).to have_content('Your Information')

    fill_in 'user[first_name]', with: 'Francis'
    fill_in 'user[last_name]', with: 'Asterisk'
    fill_in 'user[profile_name]', with: 'Pacman'
    fill_in 'user[email]', with: 'pacman@mustache.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('All of the Statuses')
  end
end
