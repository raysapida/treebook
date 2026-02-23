require 'rails_helper'

describe UserFriendshipsController do
  let(:original) { create(:user) }
  let(:other) { create(:user) }

  describe 'check factories are valid' do
    it 'pending friendship' do
      pending_friendship = create(:pending_user_friendship,
                                  user: original,
                                  friend: create(:user,
                                                 first_name: 'Pending',
                                                 last_name: 'Friend')
                                 )
      expect(pending_friendship).to be_valid
    end

    it 'accepted friendship' do
      accepted_friendship = create(:accepted_user_friendship,
                                   user: original,
                                   friend: create(:user,
                                                  first_name: 'Active',
                                                  last_name: 'Friend')
                                  )
      expect(accepted_friendship).to be_valid
    end

    it 'requested friendship' do
      requested_friendship = create(:requested_user_friendship,
                                    user: original,
                                    friend: create(:user,
                                                   first_name: 'Requested',
                                                   last_name: 'Friend')
                                   )
      expect(requested_friendship).to be_valid
    end
  end

  describe 'GET index' do
    it 'without a signed in user' do
      get :index

      expect(response).to redirect_to(login_path)
    end

    it 'with a signed in user' do
      sign_in original, scope: :user

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

    context 'with a signed in user' do
      before do
        sign_in original, scope: :user
      end

      it 'render new template' do
        get :new

        expect(response).to render_template(:new)
      end

      it 'with a signed in user without friend_id' do
        get :new, params: {}

        expect(flash[:error]).to eq('Friend required')
      end

      it 'with a signed in user should assign correct friend' do
        get :new, params: { friend_id: other }

        expect(assigns(:user_friendship).friend).to eq(other)
      end

      it 'with a signed in user should return 404 if friend not found' do
        get :new, params: { friend_id: 'invalid' }

        expect(response.status).to eq(404)
      end
    end
  end

  describe 'POST create' do
    it 'with a signed in user and empty request redirect to root' do
      sign_in original, scope: :user

      post :create

      expect(response).to redirect_to(root_path)
    end

    context 'with correct friend and signed in user' do
      before do
        sign_in original, scope: :user
        post :create, params: { user_friendship: { friend_id: other } }
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
        put :accept, params: { id: 1 }

        expect(response).to redirect_to(login_path)
      end
    end

    context 'when logged in' do
      let(:friend) { create(:user) }
      let(:pending_friendship) { create(:pending_user_friendship,
                                        user: original,
                                        friend: friend)
      }

      before do
        create(:pending_user_friendship, user: friend, friend: original)
        sign_in original, scope: :user
        put :accept, params: { id: pending_friendship }
        pending_friendship.reload
      end

      it 'should assign pending_friendship to user_friendship' do
        expect(assigns(:user_friendship)).to eq(pending_friendship)
      end

      it 'should change state to accepted' do
        expect(pending_friendship.state).to eq('accepted')
      end

      it 'should flash a success message' do
        expect(flash[:success]).to eq("You are now friends with #{pending_friendship.friend.first_name}")
      end
    end

    context 'creates an activity' do
      let(:friend) { create(:user) }
      let(:pending_friendship) { create(:pending_user_friendship,
                                        user: original,
                                        friend: friend)
      }

      it 'with proper parameters' do
        create(:pending_user_friendship, user: friend, friend: original)
        sign_in original, scope: :user

        expect {
          put :accept, params: { id: pending_friendship }
          pending_friendship.reload
        }.to change(Activity, :count).by(1)
      end
    end
  end

  describe '#edit' do
    context 'when not logged in' do
      it 'redirect to login page' do
        put :edit, params: { id: 1 }

        expect(response).to redirect_to(login_path)
      end
    end

    context 'when logged in' do
    let(:pending_friendship) { create(:pending_user_friendship,
                                      user: original)
    }

    before do
      sign_in original, scope: :user
      put :edit, params: { id: pending_friendship.friend.profile_name }
      pending_friendship.reload
    end

    it 'assign pending_friendship to user_friendship' do
      expect(assigns(:user_friendship)).to eq(pending_friendship)
    end

    it 'the response should be successful' do
      expect(response).to be_success
    end

    it 'assign friend' do
      expect(assigns(:friend)).to eq(pending_friendship.friend)
    end
  end
end

describe '#destroy' do
  context 'when not logged in' do
    it 'redirect to login page' do
      delete :destroy, params: { id: 1 }

      expect(response).to redirect_to(login_path)
    end
  end

  context 'when logged in' do
    let(:friend) { create(:user) }
    let!(:accepted_friendship) { create(:accepted_user_friendship,
                                        user: original,
                                        friend: friend)
    }

    before do
      create(:accepted_user_friendship, user: friend, friend: original)
      sign_in original, scope: :user
    end

    it 'delete user friendship' do
      expect {
        delete :destroy, params: { id: accepted_friendship }
      }.to change(UserFriendship, :count).by(-2)
    end

    it 'should flash a success message' do
      delete :destroy, params: { id: accepted_friendship }

      expect(flash[:success]).to eq('Friendship destroyed')
    end
  end
end


describe '#block' do
  context 'when not logged in' do
    it 'redirect to login page' do
      put :block, params: { id: 1 }

      expect(response).to redirect_to(login_path)
    end
  end

  context 'when logged in' do
    let(:friend) { create(:user) }
    let(:friendship) { create(:pending_user_friendship,
                              user: original,
                              friend: friend)
    }

    before do
      create(:pending_user_friendship, user: friend, friend: original)
      sign_in original, scope: :user
      put :block, params: { id: friendship }
      friendship.reload
    end

    it 'should assign friendship to user_friendship' do
      expect(assigns(:user_friendship)).to eq(friendship)
    end

    it 'should change state to blocked' do
      expect(friendship.state).to eq('blocked')
    end

    it 'should flash a success message' do
      expect(flash[:success]).to eq("You have blocked #{friendship.friend.first_name}")
    end
  end
end

end
