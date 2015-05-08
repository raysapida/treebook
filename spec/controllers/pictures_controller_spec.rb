require 'rails_helper'
require 'rack/test'

RSpec.describe PicturesController, type: :controller do
  let(:album) { create(:album) }
  let(:picture) { create(:picture) }
  let(:different_user) { create(:user) }

  let(:valid_attributes) {
    {user_id: album.user,
     album_id: album,
     asset: Rack::Test::UploadedFile.new("#{Rails.root}/spec/images/rails.png", 'image/png'),
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

  describe "GET #index" do
    it "assigns all pictures as @pictures" do
      get :index, { profile_name: picture.album.user,
                    album_id: picture.album }, valid_session

      expect(assigns(:pictures)).to eq([picture])
    end
  end

  describe "GET #show" do
    it "assigns the requested picture as @picture" do
      get :show, { profile_name: picture.album.user,
                   album_id: picture.album,
                   id: picture }, valid_session

      expect(assigns(:picture)).to eq(picture)
    end
  end

  describe "GET #new" do
    context "with correct signed in user" do
      it "assigns a new picture as @picture" do
        sign_in :user, album.user

        get :new, { profile_name: album.user,
                    album_id: album }, valid_session

        expect(assigns(:picture)).to be_a_new(Picture)
      end
    end

    context "with incorrect signed in user" do
      it "will flash an error message" do
        sign_in :user, different_user

        get :new, { profile_name: album.user,
                    album_id: album }, valid_session

        expect(flash[:error]).to match(/You don't have permission to do that./)
      end

      it "will redirect to album" do
        sign_in :user, different_user

        get :new, { profile_name: album.user,
                    album_id: album }, valid_session

        expect(response).to redirect_to(album_pictures_path(album))
      end
    end
  end

  describe "GET #edit" do
    context "with correct signed in user" do
      it "assigns the requested picture as @picture" do
        sign_in :user, picture.album.user

        get :edit, { profile_name: picture.album.user,
                     album_id: picture.album,
                     id: picture }, valid_session

        expect(assigns(:picture)).to eq(picture)
      end
    end

    context "with incorrect signed in user" do
      it "will flash an error message" do
        sign_in :user, different_user

        get :edit, { profile_name: picture.album.user,
                     album_id: picture.album,
                     id: picture }, valid_session

        expect(flash[:error]).to match(/You don't have permission to do that./)
      end

      it "will redirect to album" do
        sign_in :user, different_user

        get :edit, { profile_name: picture.album.user,
                     album_id: picture.album,
                     id: picture }, valid_session

        expect(response).to redirect_to(album_pictures_path(picture.album))
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Picture" do
        sign_in :user, album.user

        expect {
          post :create, {picture: valid_attributes,
                         profile_name: album.user,
                         album_id: album}, valid_session
        }.to change(Picture, :count).by(1)
      end

      it "assigns a newly created picture as @picture" do
        sign_in :user, album.user

        post :create, {picture: valid_attributes,
                       profile_name: album.user,
                       album_id: album}, valid_session

        expect(assigns(:picture)).to be_a(Picture)
        expect(assigns(:picture)).to be_persisted
      end

      it "redirects to the album of the created picture" do
        sign_in :user, album.user

        post :create, {picture: valid_attributes,
                       profile_name: album.user,
                       album_id: album}, valid_session

        expect(response).to redirect_to(album_pictures_path(album))
      end

      it "creates an activity" do
        sign_in :user, album.user

        expect {
          post :create, {picture: valid_attributes,
                         profile_name: album.user,
                         album_id: album}, valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved picture as @picture" do
        sign_in :user, album.user

        post :create, {picture: invalid_attributes,
                       profile_name: album.user,
                       album_id: album}, valid_session

        expect(assigns(:picture)).to be_a_new(Picture)
      end

      it "re-renders the 'new' template" do
        sign_in :user, album.user

        post :create, {picture: invalid_attributes,
                       profile_name: album.user,
                       album_id: album}, valid_session

        expect(response).to render_template("new")
      end
    end

    context "with incorrect signed in user and valid attributes" do
      it "will flash an error message" do
        sign_in :user, different_user

        post :create, {picture: valid_attributes,
                       profile_name: album.user,
                       album_id: album}, valid_session

        expect(flash[:error]).to match(/You don't have permission to do that./)
      end

      it "will redirect to album" do
        sign_in :user, different_user

        post :create, {picture: valid_attributes,
                       profile_name: album.user,
                       album_id: album}, valid_session

        expect(response).to redirect_to(album_pictures_path(album))
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { user_id: picture.album.user,
          album_id: picture.album,
          caption: 'New caption',
          description: 'New description' }
      }

      it "updates the requested picture" do
        sign_in :user, picture.album.user

        put :update, { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: new_attributes}, valid_session
        picture.reload

        expect(picture.caption).to eq('New caption')
        expect(picture.description).to eq('New description')
      end

      it "assigns the requested picture as @picture" do
        sign_in :user, picture.album.user

        put :update, { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: valid_attributes}, valid_session

        expect(assigns(:picture)).to eq(picture)
      end

      it 'flashes a notice that the update was succesfull' do
        sign_in :user, picture.album.user

        put :update, { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: valid_attributes}, valid_session

        expect(flash[:notice]).to match(/Picture was successfully updated./)
      end

      it "redirects to the picture" do
        sign_in :user, picture.album.user

        put :update, { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: valid_attributes}, valid_session

        expect(response).to redirect_to(album_pictures_path(picture.album))
      end

      it 'creates an activity' do
        sign_in :user, picture.album.user

        expect {
          put :update, { profile_name: picture.album.user,
                         album_id: picture.album,
                         id: picture,
                         picture: valid_attributes}, valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context "with invalid params" do
      it "assigns the picture as @picture" do
        sign_in :user, picture.album.user

        put :update, { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: invalid_attributes}, valid_session

        expect(assigns(:picture)).to eq(picture)
      end

      it "re-renders the 'edit' template" do
        sign_in :user, picture.album.user

        put :update, { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: invalid_attributes}, valid_session

        expect(response).to render_template("edit")
      end
    end

    context "with incorrect signed in user and valid attributes" do
      it "will flash an error message" do
        sign_in :user, different_user

        put :update, { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: valid_attributes}, valid_session

        expect(flash[:error]).to match(/You don't have permission to do that./)
      end

      it "will redirect to album" do
        sign_in :user, different_user

        put :update, { profile_name: picture.album.user,
                       album_id: picture.album,
                       id: picture,
                       picture: valid_attributes}, valid_session

        expect(response).to redirect_to(album_pictures_path(picture.album))
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested picture" do
      sign_in :user, picture.album.user

      expect {
        delete :destroy, {profile_name: picture.album.user,
                          album_id: picture.album,
                          id: picture}, valid_session
      }.to change(Picture, :count).by(-1)
    end

    it 'flashes a notice when delete is succesfull' do
      sign_in :user, picture.album.user

      delete :destroy, {profile_name: picture.album.user,
                        album_id: picture.album,
                        id: picture}, valid_session

      expect(flash[:notice]).to match(/Picture was successfully destroyed./)
    end

    it "redirects to the album" do
      sign_in :user, picture.album.user

      delete :destroy, {profile_name: picture.album.user,
                        album_id: picture.album,
                        id: picture}, valid_session

      expect(response).to redirect_to(album_pictures_path(picture.album))
    end

    it "creates an activity" do
      sign_in :user, picture.album.user

      expect {
        delete :destroy, {profile_name: picture.album.user,
                          album_id: picture.album,
                          id: picture}, valid_session
      }.to change(Activity, :count).by(1)
    end

    context "with incorrect signed in user" do
      it "will flash an error message" do
        sign_in :user, different_user

        delete :destroy, {profile_name: picture.album.user,
                          album_id: picture.album,
                          id: picture}, valid_session

        expect(flash[:error]).to match(/You don't have permission to do that./)
      end

      it "will redirect to album" do
        sign_in :user, different_user

        delete :destroy, {profile_name: picture.album.user,
                          album_id: picture.album,
                          id: picture}, valid_session

        expect(response).to redirect_to(album_pictures_path(picture.album))
      end
    end
  end
end
