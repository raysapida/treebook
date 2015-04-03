require 'rails_helper'

describe PicturesController do
  let(:user) { create(:user) }
  let(:album) { create(:album) }
  let(:picture) { create(:picture) }

  describe 'GET index' do
    it 'with a signed in user' do
      sign_in :user, album.user

      get :index, profile_name: album.user, album_id: album

      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    it 'with a signed in user' do
      sign_in :user, picture.album.user

      get :show, profile_name: picture.album.user, album_id: picture.album, id: picture

      expect(response).to be_success
      expect(response).to render_template(:show)
    end
  end

  describe 'GET new' do
    it 'with a signed in user' do
      sign_in :user, picture.album.user
      get :new, profile_name: picture.album.user, album_id: picture.album.id, id: picture.id
      expect(response).to be_success
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    it 'with a signed in user' do
      sign_in :user, picture.album.user
      get :edit, profile_name: picture.album.user, album_id: picture.album.id, id: picture.id
      expect(response).to be_success
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    it 'with a signed in user' do
      sign_in :user, picture.album.user
      post :create, profile_name: picture.album.user.profile_name, album_id: picture.album.id , picture: {user_id: picture.album.user.id, album_id: picture.album.id, caption: picture.caption, description: picture.description}
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end

  describe 'PUT update' do
    it 'with a signed in user' do
      sign_in :user, picture.album.user
      put :update, profile_name: picture.album.user,  album_id: picture.album.id, id: picture.id, picture: { user_id: picture.album.user.id, album_id: picture.album.id, caption: picture.caption, description: picture.description}
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end

  describe 'DELETE destroy' do
    it 'with a signed in user' do
      sign_in :user, picture.album.user
      delete :destroy, profile_name: picture.album.user, album_id: picture.album.id, caption: picture.caption, description: picture.description, id: picture.id
      expect(response).to redirect_to(album_pictures_path(picture.album))
    end
  end
end

