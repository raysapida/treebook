require 'rails_helper'

describe UserFriendshipsController do
  let(:original) { create(:user) }
  let(:pending_friendship) {
    create(:pending_user_friendship,
           user: original,
           friend: create(:user,
                          first_name: 'Pending',
                          last_name: 'Friend')
          )
  }

  let(:accepted_friendship) {
    create(:accepted_user_friendship,
           user: original,
           friend: create(:user,
                          first_name: 'Active',
                          last_name: 'Friend')
          )
  }

  let(:requested_friendship) {
    create(:requested_user_friendship,
           user: original,
           friend: create(:user,
                          first_name: 'Requested',
                          last_name: 'Friend')
          )
  }

  describe 'check factories are valid' do
    it 'pending friendship' do
      expect(pending_friendship).to be_valid
    end

    it 'accepted friendship' do
      expect(accepted_friendship).to be_valid
    end

    it 'requested friendship' do
      expect(requested_friendship).to be_valid
    end
  end

  describe 'GET index' do
    it 'without a signed in user' do
      get :index

      expect(response).to redirect_to(login_path)
    end

    it 'with a signed in user' do
      sign_in :user, original

      get :index

      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    it 'without a signed in user' do
      get :new

      expect(response).to redirect_to(login_path)
    end

    it 'with a signed in user' do
      sign_in :user, original

      get :new

      expect(response).to be_success
    end

    it 'with a signed in user without friend_id' do
      sign_in :user, original

      get :new, {}

      expect(flash[:error]).to eq('Friend required')
    end

    it 'with a signed in user should assign correct friend' do
      other = create(:user)
      sign_in :user, original

      get :new, friend_id: other

      expect(assigns(:user_friendship).friend).to eq(other)
    end

    it 'with a signed in user should return 404 if friend not found' do
      sign_in :user, original

      get :new, friend_id: 'invalid'

      expect(response.status).to eq(404)
    end
  end

  describe 'POST create' do
    it 'with a signed in user and empty reques redirect to root' do
      sign_in :user, original

      post :create

      expect(response).to redirect_to(root_path)
    end

    context 'with correct friend and signed in user' do
      let(:other) { create(:user) }

      before(:each) do
        sign_in :user, original
        post :create, user_friendship: { friend_id: other }
      end

      it 'create a friendship' do
        expect(original.pending_friends).to include(other)
      end

      it 'assigns friend' do
        expect(assigns(:friend)).to eq(other)
      end

      it 'redirect to the profile page of friend' do
        expect(response).to redirect_to(profile_path(other))
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to eq('Friend request sent')
      end

      it 'assign a user_friendship object' do
        expect(assigns(:user_friendship).friend).to eq(other)
        expect(assigns(:user_friendship).user).to eq(original)
      end
    end
  end

  describe '#accept' do
    context 'when not logged in' do
      it 'redirect to login page' do
        put :accept, id: 1

        expect(response).to redirect_to(login_path)
      end
    end
end
