require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  let(:album) { create(:album) }

  let(:valid_attributes) {
    {user_id: album.user,
     album_id: album,
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
      picture = create(:picture)

      get :index, { profile_name: picture.album.user,
                    album_id: picture.album }, valid_session

      expect(assigns(:pictures)).to eq([picture])
    end
  end

  describe "GET #show" do
    it "assigns the requested picture as @picture" do
      picture = create(:picture)

      get :show, { profile_name: picture.album.user,
                   album_id: picture.album,
                   id: picture }, valid_session

      expect(assigns(:picture)).to eq(picture)
    end
  end

  describe "GET #new" do
    it "assigns a new picture as @picture" do
      sign_in :user, album.user

      get :new, { profile_name: album.user,
                  album_id: album }, valid_session

      expect(assigns(:picture)).to be_a_new(Picture)
    end
  end

  describe "GET #edit" do
    it "assigns the requested picture as @picture" do
      picture = create(:picture)
      sign_in :user, picture.album.user

      get :edit, { profile_name: picture.album.user,
                   album_id: picture.album,
                   id: picture }, valid_session

      expect(assigns(:picture)).to eq(picture)
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
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:picture){ create(:picture) }

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
    end

    context "with invalid params" do
      let(:picture){ create(:picture) }

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
  end

  describe "DELETE #destroy" do
    let(:picture){ create(:picture) }

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
  end

end
