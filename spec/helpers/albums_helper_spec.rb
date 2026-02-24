require 'rails_helper'
RSpec.describe AlbumsHelper, type: :helper do
  include Devise::Test::ControllerHelpers
  include Rails::Controller::Testing::TestProcess
  include Rails::Controller::Testing::TemplateAssertions
  it '#can_edit_album? works as intended' do
    user = create(:user)
    album = create(:album, user: user)

    sign_in user, scope: :user

    expect(helper.can_edit_album?(album)).to be_truthy
  end
end
