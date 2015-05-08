require 'rails_helper'

RSpec.describe StatusesController, type: :controller do
  let(:valid_attributes) {
    { content: 'Valid content' }
  }

  let(:invalid_attributes) {
    { content: nil }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all statuses as @statuses" do
      status = create(:status)

      get :index, {}, valid_session

      expect(assigns(:statuses)).to eq([status])
    end

    context 'signed in with blocked friends' do
      let(:user) { create(:user) }
      let(:frienship) { create(:blocked_user_friendship, user: user) }

      it "should not display blocked user's posts " do
        pending('blocking statuses from blocked friends not implemented yet')
        blocked_status = frienship.friend.statuses.create(content: 'Blocked status')
        status = create(:status, content: 'Non-blocked status')

        sign_in :user, user
        get :index, {}, valid_session

        expect(assigns(:statuses)).to eq([status])
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested status as @status" do
      status = create(:status)

      get :show, {id: status}, valid_session

      expect(assigns(:status)).to eq(status)
    end
  end

  describe "GET #new" do
    it "assigns a new status as @status" do
      user = create(:user)
      sign_in :user, user

      get :new, {}, valid_session

      expect(assigns(:status)).to be_a_new(Status)
    end
  end

  describe "GET #edit" do
    it "assigns the requested status as @status" do
      status = create(:status)
      sign_in :user, status.user

      get :edit, {id: status}, valid_session

      expect(assigns(:status)).to eq(status)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Status" do
        user = create(:user)
        sign_in :user, user

        expect {
          post :create, {:status => valid_attributes}, valid_session
        }.to change(Status, :count).by(1)
      end

      it "assigns a newly created status as @status" do
        user = create(:user)
        sign_in :user, user

        post :create, {:status => valid_attributes}, valid_session

        expect(assigns(:status)).to be_a(Status)
        expect(assigns(:status)).to be_persisted
      end

      it "redirects to the created status" do
        user = create(:user)
        sign_in :user, user

        post :create, {:status => valid_attributes}, valid_session

        expect(response).to redirect_to(Status.last)
      end

      it "creates an activity" do
        user = create(:user)
        sign_in :user, user

        expect {
          post :create, {:status => valid_attributes}, valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved status as @status" do
        user = create(:user)
        sign_in :user, user

        post :create, {:status => invalid_attributes}, valid_session

        expect(assigns(:status)).to be_a_new(Status)
      end

      it "re-renders the 'new' template" do
        user = create(:user)
        sign_in :user, user

        post :create, {:status => invalid_attributes}, valid_session

        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { content: 'New content' }
      }

      it "updates the requested status" do
        status = create(:status)
        sign_in :user, status.user

        put :update, {id: status, status: new_attributes}, valid_session
        status.reload

        expect(status.content).to eq('New content')
      end

      it "assigns the requested status as @status" do
        status = create(:status)
        sign_in :user, status.user

        put :update, {id: status, status: valid_attributes}, valid_session

        expect(assigns(:status)).to eq(status)
      end

      it "redirects to the status" do
        status = create(:status)
        sign_in :user, status.user

        put :update, {id: status, status: valid_attributes}, valid_session

        expect(response).to redirect_to(status)
      end

      it "creates an activity" do
        status = create(:status)
        sign_in :user, status.user

        expect {
          put :update, {id: status, status: valid_attributes}, valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context "with invalid params" do
      it "assigns the status as @status" do
        status = create(:status)
        sign_in :user, status.user

        put :update, {id: status, status: invalid_attributes}, valid_session

        expect(assigns(:status)).to eq(status)
      end

      it "re-renders the 'edit' template" do
        status = create(:status)
        sign_in :user, status.user

        put :update, {id: status, status: invalid_attributes, user_id: status.user}, valid_session

        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested status" do
      status = create(:status)
      sign_in :user, status.user

      expect {
        delete :destroy, {id: status}, valid_session
      }.to change(Status, :count).by(-1)
    end

    it "redirects to the statuses list" do
      status = create(:status)
      sign_in :user, status.user

      delete :destroy, {id: status}, valid_session
      expect(response).to redirect_to(statuses_url)
    end

    it "creates an activity" do
      status = create(:status)
      sign_in :user, status.user

      expect {
        delete :destroy, {id: status}, valid_session
      }.to change(Activity, :count).by(1)
    end
  end

end
