require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  let(:album) { create(:album) }
  let(:picture) { create(:picture) }
  let(:different_user) { create(:user) }

  let(:valid_attributes) {
    {user_id: album.user,
     album_id: album,
     asset: fixture_file_upload("#{Rails.root}/spec/images/rails.png", 'image/png'),
     caption: 'Valid caption',
     description: 'Valid description' }
  }

  let(:invalid_attributes) {
    {user_id: nil,
     album_id: nil,
     caption: nil,
     description: nil }
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    before do
      get :index, params: { profile_name: picture.album.user,
                    album_id: picture.album }, session: valid_session
    end

    it 'assigns all pictures as @pictures' do
      expect(assigns(:pictures)).to eq([picture])
    end

    it 'render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { profile_name: picture.album.user,
                   album_id: picture.album,
                   id: picture }, session: valid_session
    end

    it 'assigns the requested picture as @picture' do
      expect(assigns(:picture)).to eq(picture)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    context 'with correct signed in user' do
      before do
        sign_in album.user, scope: :user
        get :new, params: { profile_name: album.user,
                    album_id: album }, session: valid_session
      end

      it 'assigns a new picture as @picture' do
        expect(assigns(:picture)).to be_a_new(Picture)
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'with incorrect signed in user' do
      before do
        sign_in different_user, scope: :user

        get :new, params: { profile_name: album.user,
                    album_id: album }, session: valid_session
      end

      it 'will flash an error message' do
        expect(flash[:error]).to match(/You don't have permission to do that./)
      end

      it 'will redirect to album' do
        expect(response).to redirect_to(album_pictures_path(album))
      end
    end
  end

  describe 'GET #edit' do
    context 'with correct signed in user' do
      before do
        sign_in picture.album.user, scope: :user
        get :edit, params: { profile_name: picture.album.user,
                     album_id: picture.album,
                     id: picture }, session: valid_session
      end

      it 'assigns the requested picture as @picture' do
        expect(assigns(:picture)).to eq(picture)
      end

      it 'render edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'with incorrect signed in user' do
      before do
        sign_in different_user, scope: :user
        get :edit, params: { profile_name: picture.album.user,
                     album_id: picture.album,
                     id: picture }, session: valid_session
      end

      it 'will flash an error message' do
        expect(flash[:error]).to match(/You don't have permission to do that./)
      end

      it 'will redirect to album' do
        expect(response).to redirect_to(album_pictures_path(picture.album))
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        sign_in album.user, scope: :user
      end

      it 'creates a new Picture' do
        expect {
          post :create, params: {picture: valid_attributes,
                         profile_name: album.user,
                         album_id: album}, session: valid_session
        }.to change(Picture, :count).by(1)
      end

      it 'assigns a newly created picture as @picture' do
        post :create, params: {picture: valid_attributes,
                       profile_name: album.user,
                       album_id: album}, session: valid_session

        expect(assigns(:picture)).to be_a(Picture)
        expect(assigns(:picture)).to be_persisted
      end

      it 'redirects to the album of the created picture' do
        post :create, params: {picture: valid_attributes,
                       profile_name: album.user,
                       album_id: album}, session: valid_session

        expect(response).to redirect_to(album_pictures_path(album))
      end

      it 'creates an activity' do
        expect {
          post :create, params: {picture: valid_attributes,
                         profile_name: album.user,
                         album_id: album}, session: valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context 'with invalid params' do
      before do
        sign_in album.user, scope: :user
        post :create, params: {picture: invalid_attributes,
                       profile_name: album.user,
                       album_id: album}, session: valid_session
      end

      it 'assigns a newly created but unsaved picture as @picture' do
        expect(assigns(:picture)).to be_a_new(Picture)
      end

      it 're-renders the new template' do
        expect(response).to render_template('new')
      end
    end

    context 'with incorrect signed in user and valid attributes' do
      before do
        sign_in different_user, scope: :user
        post :create, params: {picture: valid_attributes,
                       profile_name: album.user,
                       album_id: album}, session: valid_session
      end

      it 'will flash an error message' do
        expect(flash[:error]).to match(/You don't have permission to do that./)
      end

      it 'will redirect to album' do
        expect(response).to redirect_to(album_pictures_path(album))
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        sign_in picture.album.user, scope: :user
        put :update, params: { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: new_attributes}, session: valid_session
      end

      let(:new_attributes) {
        { user_id: picture.album.user,
          album_id: picture.album,
          caption: 'New caption',
          description: 'New description' }
      }

      it 'updates the requested picture' do
        picture.reload

        expect(picture.caption).to eq('New caption')
        expect(picture.description).to eq('New description')
      end

      it 'assigns the requested picture as @picture' do
        expect(assigns(:picture)).to eq(picture)
      end

      it 'flashes a notice that the update was succesfull' do
        expect(flash[:notice]).to match(/Picture was successfully updated./)
      end

      it 'redirects to the picture' do
        expect(response).to redirect_to(album_pictures_path(picture.album))
      end

      it 'creates an activity' do
        expect {
          put :update, params: { profile_name: picture.album.user,
                         album_id: picture.album,
                         id: picture,
                         picture: valid_attributes}, session: valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context 'with invalid params' do
      before do
        sign_in picture.album.user, scope: :user
        put :update, params: { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: invalid_attributes}, session: valid_session
      end

      it 'assigns the picture as @picture' do
        expect(assigns(:picture)).to eq(picture)
      end

      it 're-renders the edit template' do
        expect(response).to render_template('edit')
      end
    end

    context 'with incorrect signed in user and valid attributes' do
      before do
        sign_in different_user, scope: :user
        put :update, params: { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: valid_attributes}, session: valid_session
      end

      it 'will flash an error message' do
        expect(flash[:error]).to match(/You don't have permission to do that./)
      end

      it 'will redirect to album' do
        expect(response).to redirect_to(album_pictures_path(picture.album))
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in picture.album.user, scope: :user
    end

    it 'destroys the requested picture' do
      expect {
        delete :destroy, params: {profile_name: picture.album.user,
                          album_id: picture.album,
                          id: picture}, session: valid_session
      }.to change(Picture, :count).by(-1)
    end

    it 'flashes a notice when delete is succesfull' do
      delete :destroy, params: {profile_name: picture.album.user,
                        album_id: picture.album,
                        id: picture}, session: valid_session

      expect(flash[:notice]).to match(/Picture was successfully destroyed./)
    end

    it 'redirects to the album' do
      delete :destroy, params: {profile_name: picture.album.user,
                        album_id: picture.album,
                        id: picture}, session: valid_session

      expect(response).to redirect_to(album_pictures_path(picture.album))
    end

    it 'creates an activity' do
      expect {
        delete :destroy, params: {profile_name: picture.album.user,
                          album_id: picture.album,
                          id: picture}, session: valid_session
      }.to change(Activity, :count).by(1)
    end

    context 'with incorrect signed in user' do
      before do
        sign_in different_user, scope: :user
        delete :destroy, params: {profile_name: picture.album.user,
                          album_id: picture.album,
                          id: picture}, session: valid_session
      end

      it 'will flash an error message' do
        expect(flash[:error]).to match(/You don't have permission to do that./)
      end

      it 'will redirect to album' do
        expect(response).to redirect_to(album_pictures_path(picture.album))
      end
    end
  end
end
