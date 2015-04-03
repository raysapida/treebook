require 'rails_helper'

describe PicturesController do
  let!(:different_user) { create(:user) }
  let!(:picture) { create(:picture) }
  let!(:default_params) {  {profile_name: picture.album.user, album_id: picture.album} }
  let!(:picture_params) do 
    {
      picture: {user_id: picture.album.user, 
                album_id: picture.album, 
                caption: picture.caption, 
                description: picture.description}
    }
  end

  describe 'GET index' do
    it 'without a signed in user' do
      get :index, default_params

      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    it 'without a signed in user' do
      get :show, default_params.merge(id: picture)

      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end

  describe 'GET new' do
    it 'with the current signed in user' do
      sign_in :user, picture.album.user

      get :new, default_params.merge(id: picture)

      expect(response).to be_success
      expect(response).to render_template(:new)
    end

    it 'with a different signed in user' do
      sign_in :user, different_user

      get :new, default_params.merge(id: picture)

      expect(flash[:error]).to match(/You don't have permission to do that./)
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end

  describe 'GET edit' do
    it 'with the current signed in user' do
      sign_in :user, picture.album.user

      get :edit, default_params.merge(id: picture)
      
      expect(response).to be_success
      expect(response).to render_template(:edit)
    end

    it 'with a different signed in user' do
      sign_in :user, different_user

      get :edit, default_params.merge(id: picture)

      expect(flash[:error]).to match(/You don't have permission to do that./)
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end

  describe 'POST create' do
    it 'with the signed in user' do
      sign_in :user, picture.album.user

      post :create, default_params.merge(picture_params)

      expect(flash[:notice]).to match(/Picture was successfully created./)
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end

    it 'with a different signed in user' do
      sign_in :user, different_user

      post :create, default_params.merge(picture_params)

      expect(flash[:error]).to match(/You don't have permission to do that./)
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end

  describe 'PUT update' do
    it 'with the current signed in user' do
      sign_in :user, picture.album.user

      put :update, default_params.merge(picture_params).merge(id: picture)

      expect(flash[:notice]).to match(/Picture was successfully updated./)
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end

    it 'with a different signed in user' do
      sign_in :user, different_user

      put :update, default_params.merge(picture_params).merge(id: picture)

      expect(flash[:error]).to match(/You don't have permission to do that./)
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end

  describe 'DELETE destroy' do
    it 'with a signed in user' do
      sign_in :user, picture.album.user

      delete :destroy, default_params.merge(id: picture)

      expect(flash[:notice]).to match(/Picture was successfully destroyed./)
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end

    it 'with a different signed in user' do
      sign_in :user, different_user

      delete :destroy, default_params.merge(id: picture)

      expect(flash[:error]).to match(/You don't have permission to do that./)
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end
end

