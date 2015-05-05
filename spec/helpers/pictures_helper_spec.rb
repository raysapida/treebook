require 'rails_helper'
include Devise::TestHelpers

RSpec.describe PicturesHelper, type: :helper do
  it '#can_edit_picture? works as intended' do
    user = create(:user)
    picture = create(:picture, user: user)

    sign_in :user, user

    expect(helper.can_edit_picture?(picture)).to be_truthy
  end
end
