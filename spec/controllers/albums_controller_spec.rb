require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  let(:valid_attributes) {
    { title: "Valid title"}
  }

  let(:invalid_attributes) {
    { title: nil }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all albums as @albums" do
      album = create(:album)

      get :index, {profile_name: album.user}, valid_session

      expect(assigns(:albums)).to eq([album])
    end
  end

  describe "GET #show" do
    it "assigns the requested album as @album" do
      album = create(:album)

      get :show, {id: album, profile_name: album.user}, valid_session

      expect(response).to redirect_to(album_pictures_path(album))
    end
  end

  describe "GET #new" do
    it "assigns a new album as @album" do
      user = create(:user)
      sign_in :user, user

      get :new, {profile_name: user}, valid_session

      expect(assigns(:album)).to be_a_new(Album)
    end
  end

  describe "GET #edit" do
    it "assigns the requested album as @album" do
      album = create(:album)
      sign_in :user, album.user

      get :edit, {id: album, profile_name: album.user }, valid_session

      expect(assigns(:album)).to eq(album)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Album" do
        user = create(:user)
        sign_in :user, user

        expect {
          post :create, {:album => valid_attributes, profile_name: user}, valid_session
        }.to change(Album, :count).by(1)
      end

      it "assigns a newly created album as @album" do
        user = create(:user)
        sign_in :user, user

        post :create, {:album => valid_attributes, profile_name: user}, valid_session

        expect(assigns(:album)).to be_a(Album)
        expect(assigns(:album)).to be_persisted
      end

      it "redirects to the created album" do
        user = create(:user)
        sign_in :user, user

        post :create, {:album => valid_attributes, profile_name: user}, valid_session

        expect(response).to redirect_to(Album.last)
      end

      it "creates an activivy" do
        user = create(:user)
        sign_in :user, user

        expect {
          post :create, {:album => valid_attributes, profile_name: user}, valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved album as @album" do
        user = create(:user)
        sign_in :user, user

        post :create, {:album => invalid_attributes, profile_name: user}, valid_session

        expect(assigns(:album)).to be_a_new(Album)
      end

      it "re-renders the 'new' template" do
        user = create(:user)
        sign_in :user, user

        post :create, {:album => invalid_attributes, profile_name: user}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: 'New title' }
      }

      it "updates the requested album" do
        album = create(:album)
        sign_in :user, album.user

        put :update, {id: album, album: new_attributes, profile_name: album.user}, valid_session
        album.reload

        expect(album.title).to eq('New title')
      end

      it "assigns the requested album as @album" do
        album = create(:album)
        sign_in :user, album.user

        put :update, {id: album, album: valid_attributes, profile_name: album.user}, valid_session

        expect(assigns(:album)).to eq(album)
      end

      it "redirects to the album" do
        album = create(:album)
        sign_in :user, album.user

        put :update, {id: album, album: valid_attributes, profile_name: album.user}, valid_session

        expect(response).to redirect_to(album_pictures_path(album))
      end

      it "creates an activity" do
        album = create(:album)
        sign_in :user, album.user

        expect {
          put :update, {id: album, album: valid_attributes, profile_name: album.user}, valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context "with invalid params" do
      it "assigns the album as @album" do
        album = create(:album)
        sign_in :user, album.user

        put :update, {id: album, album: invalid_attributes, profile_name: album.user}, valid_session

        expect(assigns(:album)).to eq(album)
      end

      it "re-renders the 'edit' template" do
        album = create(:album)
        sign_in :user, album.user

        put :update, {id: album.to_param, album: invalid_attributes, profile_name: album.user}, valid_session

        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested album" do
      album = create(:album)
      sign_in :user, album.user

      expect {
        delete :destroy, {id: album, profile_name: album.user}, valid_session
      }.to change(Album, :count).by(-1)
    end

    it "redirects to the albums list" do
      album = create(:album)
      sign_in :user, album.user

      delete :destroy, {id: album, profile_name: album.user}, valid_session
      expect(response).to redirect_to(albums_url)
    end

    it "creates an activity" do
      album = create(:album)
      sign_in :user, album.user

      expect {
        delete :destroy, {id: album, profile_name: album.user}, valid_session
      }.to change(Activity, :count).by(1)
    end
  end

end
