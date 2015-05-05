require 'rails_helper'
include Devise::TestHelpers

RSpec.describe AlbumsHelper, type: :helper do
  it '#can_edit_album? works as intended' do
    user = create(:user)
    album = create(:album, user: user)

    sign_in :user, user

    expect(helper.can_edit_album?(album)).to be_truthy
  end
end
