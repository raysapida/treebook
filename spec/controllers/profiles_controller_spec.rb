require 'rails_helper'

describe ProfilesController do
  let(:user) { create(:user) }

  describe 'GET show' do
    it 'success with signed in user' do
      sign_in user, scope: :user
      get :show, id: user.profile_name

      expect(response).to be_success
    end

    it 'should render a 404 on profile not found' do
      get :show, id: "doesn't exist"

      expect(response).to have_http_status(404)
    end

    it 'that variables are assigned on successful profile viewing' do
      other = create(:user)

      sign_in user, scope: :user
      get :show, id: other.profile_name

      expect(assigns(:user)).to eq(other)
    end

    it 'only shows the correct user statuses' do
      other = create(:user)
      create(:status, user: other)
      create(:status, user: other)
      create(:status, user: other)

      sign_in user, scope: :user
      get :show, id: other.profile_name

      assigns(:statuses).each do |status|
        expect(status.user).to eq(other)
      end
    end
  end

end
