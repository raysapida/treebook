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

  let(:blocked_friendship) { 
    create(:blocked_user_friendships, 
           user: original, 
           friend: create(:user,
                          first_name: 'Blocked', 
                          last_name: 'Friend')
          )
  }

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
  end
end
