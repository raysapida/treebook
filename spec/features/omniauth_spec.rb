require 'rails_helper'

describe "access top page", type: :feature do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end

  it "can sign in user with Twitter account" do
    visit '/'
    expect(page).to have_content("Sign in with Twitter")
    mock_auth_hash
    click_link "Sign in with Twitter"
    expect(page).to have_content("mockuser")  # user name
    expect(page).to have_css('img', :src => 'mock_user_thumbnail_url') # user image
    expect(page).to have_content("Sign out")
  end

  it "can handle authentication error" do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    visit '/'
    expect(page).to have_content("Sign in with Twitter")
    click_link "Sign in with Twitter"
    expect(page).to have_content('Invalid credentials')
  end

end
