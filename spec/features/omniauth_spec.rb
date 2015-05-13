require 'rails_helper'

describe 'logging in through social logins', type: :feature do
  describe 'twitter omniauth' do
    it 'can sign in user with Twitter account' do
      visit '/'
      expect(page).to have_content('Sign in with Twitter')
      mock_auth_twitter
      click_link 'Sign in with Twitter'
      expect(page).to have_content('Successfully authenticated from Twitter account.')
      expect(page).to have_content('Log Out')
    end

    it 'can handle authentication error' do
      OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
      visit '/'
      expect(page).to have_content('Sign in with Twitter')
      click_link 'Sign in with Twitter'
      expect(page).to have_content('Invalid credentials')
    end
  end

  describe 'facebook omniauth' do
    it 'can sign in user with Facebook account' do
      visit '/'
      expect(page).to have_content('Sign in with Facebook')
      mock_auth_facebook
      click_link 'Sign in with Facebook'
      expect(page).to have_content('Successfully authenticated from Facebook account.')
      expect(page).to have_content('Log Out')
    end

    it 'can handle authentication error' do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
      visit '/'
      expect(page).to have_content('Sign in with Facebook')
      click_link 'Sign in with Facebook'
      expect(page).to have_content('Invalid credentials')
    end
  end

  describe 'instagram omniauth' do
    it 'can sign in user with Instagram account' do
      visit '/'
      expect(page).to have_content('Sign in with Instagram')
      mock_auth_instagram
      click_link 'Sign in with Instagram'
      expect(page).to have_content('Successfully authenticated from Instagram account.')
      expect(page).to have_content('Log Out')
    end

    it 'can handle authentication error' do
      OmniAuth.config.mock_auth[:instagram] = :invalid_credentials
      visit '/'
      expect(page).to have_content('Sign in with Instagram')
      click_link 'Sign in with Instagram'
      expect(page).to have_content('Invalid credentials')
    end
  end

  describe 'google omniauth' do
    it 'can sign in user with Google account' do
      visit '/'
      expect(page).to have_content('Sign in with Google Oauth2')
      mock_auth_google
      click_link 'Sign in with Google Oauth2'
      expect(page).to have_content('Successfully authenticated from Google_oauth2 account.')
      expect(page).to have_content('Log Out')
    end

    it 'can handle authentication error' do
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
      visit '/'
      expect(page).to have_content('Sign in with Google Oauth2')
      click_link 'Sign in with Google Oauth2'
      expect(page).to have_content('Invalid credentials')
    end
  end
end
