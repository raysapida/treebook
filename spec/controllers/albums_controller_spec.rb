require 'rails_helper'

describe AlbumsController do
  let!(:different_user) { create(:user) }
  let!(:album) { create(:album) }
  let!(:picture) { create(:picture) }
  let!(:default_params) {  {profile_name: picture.album.user, album_id: picture.album} }
  let!(:picture_params) do 
    {
      picture: {user_id: picture.album.user, 
                album_id: picture.album, 
                picture_id: picture.id,
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
      get :show, profile_name: picture.album.user, id: picture.album

      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end

  describe 'GET new' do
    it 'with the current signed in user' do
      sign_in :user, picture.album.user

      get :new, default_params

      expect(response).to be_success
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    it 'with the current signed in user' do
      sign_in :user, picture.album.user

      get :edit, default_params.merge(id: picture.album)

      expect(response).to be_success
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    it 'with the signed in user' do
      sign_in :user, picture.album.user

      post :create, default_params.merge(picture_params)

      expect(flash[:notice]).to match(/Album was successfully created./)
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end

  describe 'PUT update' do
    it 'with the current signed in user' do
      sign_in :user, picture.album.user

      put :update, default_params.merge(picture_params)

      expect(flash[:notice]).to match(/Album was successfully updated./)
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end

  describe 'DELETE destroy' do
    it 'with a signed in user' do
      sign_in :user, picture.album.user

      delete :destroy, default_params.merge(id: picture.album)

      expect(flash[:notice]).to match(/Album was successfully destroyed./)
      expect(response).to redirect_to(albums_path)
    end
  end
end

