module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
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
end
