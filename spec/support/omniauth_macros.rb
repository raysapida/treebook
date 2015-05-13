module OmniauthMacros
  def mock_auth_twitter
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      'provider' => 'twitter',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        'email' => 'mock@example.com',
        'nickname' => 'mocky',
        'image' => 'mock_user_thumbnail_url',
        'phone' => '1234567890',
      },
      'credentials' => {
        'token' => 'mock_token',
        'refresh_token' => 'mock_refresh',
        'secret' => 'mock_secret'
      },
    })
  end

  def mock_auth_facebook
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        'email' => 'mock@example.com',
        'nickname' => 'mocky',
        'image' => 'mock_user_thumbnail_url',
        'phone' => '1234567890',
      },
      'credentials' => {
        'token' => 'mock_token',
        'refresh_token' => 'mock_refresh',
        'secret' => 'mock_secret'
      },
    })
  end

  def mock_auth_instagram
    OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new({
      'provider' => 'instagram',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        'email' => 'mock@example.com',
        'nickname' => 'mocky',
        'image' => 'mock_user_thumbnail_url',
        'phone' => '1234567890',
      },
      'credentials' => {
        'token' => 'mock_token',
        'refresh_token' => 'mock_refresh',
        'secret' => 'mock_secret'
      },
    })
  end

  def mock_auth_google
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      'provider' => 'google_oauth2',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        'email' => 'mock@example.com',
        'nickname' => 'mocky',
        'image' => 'mock_user_thumbnail_url',
        'phone' => '1234567890',
      },
      'credentials' => {
        'token' => 'mock_token',
        'refresh_token' => 'mock_refresh',
        'secret' => 'mock_secret'
      },
    })
  end

end
