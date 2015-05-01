require 'rails_helper'

describe "the registration process", :type => :feature do
  it "fills in valid information in the form" do
    visit root_path
    expect(page).to have_content("Log In")
    click_link "Register"
    expect(page).to have_content("Your Information")
    fill_in "First name", :with => "Francis"
    fill_in "Last name", :with => "Asterisk"
    fill_in "Profile name", :with => "Pacman"
    fill_in "Email", :with => "pacman@mustache.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("All of the Statuses")
  end
end
