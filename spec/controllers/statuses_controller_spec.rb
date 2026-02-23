require 'rails_helper'

RSpec.describe StatusesController, type: :controller do
  let(:status) { create(:status) }
  let(:user) { create(:user) }
  let(:valid_attributes) {
    { content: 'Valid content' }
  }

  let(:invalid_attributes) {
    { content: nil }
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all statuses as @statuses' do
      get :index, params: {}, session: valid_session

      expect(assigns(:statuses)).to eq([status])
    end

    it 'renders index template' do
      get :index, params: {}, session: valid_session

      expect(response).to render_template(:index)
    end

    it 'should not display blocked user posts ' do
      frienship = create(:blocked_user_friendship, user: user)
      blocked_status = frienship.friend.statuses.create(content: 'Blocked status')
      status = create(:status, content: 'Non-blocked status')

      sign_in user, scope: :user
      get :index, params: {}, session: valid_session

      expect(assigns(:statuses)).to eq([status])
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: {id: status}, session: valid_session
    end

    it 'assigns the requested status as @status' do
      expect(assigns(:status)).to eq(status)
    end

    it 'render show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    before do
      sign_in user, scope: :user
      get :new, params: {}, session: valid_session
    end

    it 'assigns a new status as @status' do
      expect(assigns(:status)).to be_a_new(Status)
    end

    it 'render new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      sign_in status.user, scope: :user
      get :edit, params: {id: status}, session: valid_session
    end

    it 'assigns the requested status as @status' do
      expect(assigns(:status)).to eq(status)
    end

    it 'render edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    before do
      sign_in user, scope: :user
    end

    context 'with valid params' do
      it 'creates a new Status' do
        expect {
          post :create, params: {:status => valid_attributes}, session: valid_session
        }.to change(Status, :count).by(1)
      end

      it 'assigns a newly created status as @status' do
        post :create, params: {:status => valid_attributes}, session: valid_session

        expect(assigns(:status)).to be_a(Status)
        expect(assigns(:status)).to be_persisted
      end

      it 'redirects to the created status' do
        post :create, params: {:status => valid_attributes}, session: valid_session

        expect(response).to redirect_to(Status.last)
      end

      it 'creates an activity' do
        expect {
          post :create, params: {:status => valid_attributes}, session: valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context 'with invalid params' do
      before do
        post :create, params: {:status => invalid_attributes}, session: valid_session
      end

      it 'assigns a newly created but unsaved status as @status' do
        expect(assigns(:status)).to be_a_new(Status)
      end

      it 're-renders the new template' do
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    before do
      sign_in status.user, scope: :user
    end

    context 'with valid params' do
      let(:new_attributes) {
        { content: 'New content' }
      }

      it 'updates the requested status' do
        put :update, params: {id: status, status: new_attributes}, session: valid_session
        status.reload

        expect(status.content).to eq('New content')
      end

      it 'assigns the requested status as @status' do
        put :update, params: {id: status, status: valid_attributes}, session: valid_session

        expect(assigns(:status)).to eq(status)
      end

      it 'redirects to the status' do
        put :update, params: {id: status, status: valid_attributes}, session: valid_session

        expect(response).to redirect_to(status)
      end

      it 'creates an activity' do
        expect {
          put :update, params: {id: status, status: valid_attributes}, session: valid_session
        }.to change(Activity, :count).by(1)
      end
    end

    context 'with invalid params' do
      before do
        put :update, params: {id: status, status: invalid_attributes}, session: valid_session
      end

      it 'assigns the status as @status' do
        expect(assigns(:status)).to eq(status)
      end

      it 're-renders the edit template' do
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in status.user, scope: :user
    end

    it 'destroys the requested status' do
      expect {
        delete :destroy, params: {id: status}, session: valid_session
      }.to change(Status, :count).by(-1)
    end

    it 'redirects to the statuses list' do
      delete :destroy, params: {id: status}, session: valid_session
      expect(response).to redirect_to(statuses_url)
    end

    it 'creates an activity' do
      expect {
        delete :destroy, params: {id: status}, session: valid_session
      }.to change(Activity, :count).by(1)
    end
  end

end
