require 'rails_helper'

describe StatusesController do
  let!(:different_user) { create(:user) }
  let!(:status) { create(:status) }
  let!(:default_params) {  {profile_name: status.user } }
  let!(:status_params) do
    {
      status: {
        content: status.content
      }
    }
  end

  describe 'GET index' do
    it 'without a signed in user' do
      get :index

      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    it 'without a signed in user' do
      get :show, id: status

      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end

  describe 'GET new' do
    it 'with the current signed in user' do
      sign_in :user, status.user

      get :new, default_params

      expect(response).to be_success
      expect(response).to render_template(:new)
    end

    it 'without a signed in user' do
      get :new, default_params

      expect(response).to redirect_to(login_path)
    end
  end

  describe 'GET edit' do
    it 'with the current signed in user' do
      sign_in :user, status.user

      get :edit, default_params.merge(id: status)
      
      expect(response).to be_success
      expect(response).to render_template(:edit)
    end

    it 'without a signed in user' do
      get :edit, default_params.merge(id: status)

      expect(response).to redirect_to(login_path)
    end
  end

  describe 'POST create' do
    it 'with the signed in user' do
      sign_in :user, status.user

      post :create, status_params

      expect(flash[:notice]).to match(/Status was successfully created./)
    end

    it 'without a signed in user' do
      post :create, status: {content: status.content}

      expect(response).to redirect_to(login_path)
    end
  end

  describe 'PUT update' do
    it 'with the current signed in user' do
      sign_in :user, status.user

      put :update, status_params.merge(id: status)

      expect(flash[:notice]).to match(/Status was successfully updated./)
      expect(response).to redirect_to(status_path(status))
    end

    it 'without a signed in user' do
      put :update, status_params.merge(id: status)

      expect(response).to redirect_to(login_path)
    end
  end

  describe 'DELETE destroy' do
    it 'with the current signed in user' do
      sign_in :user, status.user

      delete :destroy, status_params.merge(id: status)

      expect(flash[:notice]).to match(/Status was successfully destroyed./)
      expect(response).to redirect_to(statuses_url)
    end
  end
end

