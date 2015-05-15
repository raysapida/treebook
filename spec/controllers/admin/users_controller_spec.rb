require 'rails_helper'

describe Admin::UsersController, type: :controller do
  before do
    @user = create(:user, email: 'admin@example.com')
    sign_in :user, @user
  end

  describe 'GET index' do
    it 'is successful' do
      get :index
      expect(response).to be_success
    end
  end
end
