require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  let(:user) { create(:user) }
  let(:album) { create(:album) }
  let(:valid_attributes) {
    { title: 'Valid title'}
  }

  let(:invalid_attributes) {
    { title: nil }
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    before do
      get :index, {profile_name: album.user}, valid_session
    end

    it 'assigns all albums as @albums' do
      expect(assigns(:albums)).to eq([album])
    end

    it 'render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'redirect to nested path' do
      get :show, {id: album, profile_name: album.user}, valid_session

      expect(response).to redirect_to(album_pictures_path(album))
    end
  end

  describe 'GET #new' do
    it 'assigns a new album as @album' do
      sign_in :user, user

      get :new, {profile_name: user}, valid_session

      expect(assigns(:album)).to be_a_new(Album)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested album as @album' do
      sign_in :user, album.user

      get :edit, {id: album, profile_name: album.user }, valid_session

      expect(assigns(:album)).to eq(album)
    end
  end

  describe 'POST #create' do
    before do
      sign_in :user, user
    end

    context 'with valid params' do
      it 'creates a new Album' do
        expect {
          post :create, {:album => valid_attributes, profile_name: user}, valid_session
        }.to change(Album, :count).by(1)
      end

      it 'assigns a newly created album as @album' do
        post :create, {:album => valid_attributes, profile_name: user}, valid_session

        expect(assigns(:album)).to be_a(Album)
        expect(assigns(:album)).to be_persisted
      end

      it 'redirects to the created album' do
        post :create, {:album => valid_attributes, profile_name: user}, valid_session

        expect(response).to redirect_to(Album.last)
      end

      it 'creates an activivy' do
        expect {
          post :create, {:album => valid_attributes, profile_name: user}, valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context 'with invalid params' do
      before do
        post :create, {:album => invalid_attributes, profile_name: user}, valid_session
      end

      it 'assigns a newly created but unsaved album as @album' do
        expect(assigns(:album)).to be_a_new(Album)
      end

      it 're-renders the new template' do
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    before do
      sign_in :user, album.user
    end

    context 'with valid params' do
      let(:new_attributes) {
        { title: 'New title' }
      }

      it 'updates the requested album' do
        put :update, {id: album, album: new_attributes, profile_name: album.user}, valid_session
        album.reload

        expect(album.title).to eq('New title')
      end

      it 'assigns the requested album as @album' do
        put :update, {id: album, album: valid_attributes, profile_name: album.user}, valid_session

        expect(assigns(:album)).to eq(album)
      end

      it 'redirects to the album' do
        put :update, {id: album, album: valid_attributes, profile_name: album.user}, valid_session

        expect(response).to redirect_to(album_pictures_path(album))
      end

      it 'creates an activity' do
        expect {
          put :update, {id: album, album: valid_attributes, profile_name: album.user}, valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context 'with invalid params' do
      before do
        put :update, {id: album, album: invalid_attributes, profile_name: album.user}, valid_session
      end

      it 'assigns the album as @album' do
        expect(assigns(:album)).to eq(album)
      end

      it 're-renders the edit template' do
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in :user, album.user
    end

    it 'destroys the requested album' do
      expect {
        delete :destroy, {id: album, profile_name: album.user}, valid_session
      }.to change(Album, :count).by(-1)
    end

    it 'redirects to the albums list' do
      delete :destroy, {id: album, profile_name: album.user}, valid_session
      expect(response).to redirect_to(albums_url)
    end

    it 'creates an activity' do
      expect {
        delete :destroy, {id: album, profile_name: album.user}, valid_session
      }.to change(Activity, :count).by(1)
    end
  end

end
