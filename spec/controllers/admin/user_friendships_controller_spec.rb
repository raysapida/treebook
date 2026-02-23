require 'rails_helper'

describe Admin::UserFriendshipsController do
  before do
    @user = create(:user, email: 'admin@example.com')
    sign_in @user, scope: :user
  end

  describe 'GET index' do
    xit 'is successful' do
      get :index
      expect(response).to be_success
    end
  end
end
