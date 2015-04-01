require 'rails_helper'

describe User do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  it { should have_many(:statuses) }
  it { should have_many(:friends) }
  it { should have_many(:user_friendships)  }
  it { should have_many(:pending_user_friendships)  }
  it { should have_many(:pending_friends)  }
  it { should have_many(:requested_user_friendships)  }
  it { should have_many(:requested_friends)  }
  it { should have_many(:blocked_user_friendships)  }
  it { should have_many(:blocked_friends)  }
  it { should have_many(:albums) }
  it { should have_many(:pictures) }
  it { should have_many(:activities)  }

  it { should validate_presence_of(:first_name)}
  it { should validate_presence_of(:last_name)}
  it { should validate_presence_of(:profile_name)}
  it { should validate_uniqueness_of(:profile_name)}

  it { should_not allow_value('ex@mple').for(:profile_name) }
  it { should_not allow_value('ex.ample').for(:profile_name) }
  it { should_not allow_value('exam ple').for(:profile_name) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it '#to_param calls profile_name' do
    expect(user.to_param).to eq(user.profile_name)
  end

  it '#full_name concatenates first_name and last_name' do
    full = "#{user.first_name} #{user.last_name}"

    expect(user.full_name).to eq(full)
  end

  it 'can call friends list' do
    expect{ user.friends }.not_to raise_error
  end

	it 'that creating friendships on a user works' do
    user.friends << friend
    user.friends.reload

    expect(user.friends).to include(friend)
  end
  
  it '#has_blocked?' do
    pending('needs a factory for user friendships')
    expect(user.has_blocked?(friend)).to be true
  end

  it '#create_activity for status' do
    pending('needs a factory for statuses')
    expect(user.create_activity(status, activity)).to change(activity.count).by(1)
  end

  it '#create_activity for album' do
    pending('needs a factory for statuses')
    expect(user.create_activity(album, activity)).to change(activity.count).by(1)
  end
end
