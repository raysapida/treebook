require 'rails_helper'

describe ActivitiesController do
  let!(:user) { create(:user) }
  describe 'GET index' do
    it 'with signed in user' do
      sign_in :user, user

      get :index

      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end
end
