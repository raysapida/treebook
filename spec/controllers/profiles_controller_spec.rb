require 'rails_helper'

describe ProfilesController do
  let(:user) { create(:user) }

  describe 'GET show' do
    it 'success with signed in user' do
      sign_in :user, user
      get :show, id: user.profile_name

      expect(response).to be_success
    end

    it 'should render a 404 on profile not found' do
      get :show, id: "doesn't exist"

      expect(response).to have_http_status(404)
    end
  end
end
