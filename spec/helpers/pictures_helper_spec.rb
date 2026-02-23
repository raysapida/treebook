require 'rails_helper'
RSpec.describe PicturesHelper, type: :helper do
  include Devise::Test::ControllerHelpers
  include Rails::Controller::Testing::TestProcess
  include Rails::Controller::Testing::TemplateAssertions
  it '#can_edit_picture? works as intended' do
    user = create(:user)
    picture = create(:picture, user: user)

    sign_in user, scope: :user

    expect(helper.can_edit_picture?(picture)).to be_truthy
  end
end
