require 'rails_helper'

describe User do
  let(:user) { build(:user) }
  let(:friend) { build(:user) }

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
  it { should have_attached_file(:avatar) }

  it { should validate_presence_of(:first_name)}
  it { should validate_presence_of(:last_name)}
  it { should validate_presence_of(:profile_name)}
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:profile_name)}
  it { should validate_uniqueness_of(:email)}
  it { should validate_attachment_content_type(:avatar).
       allowing('image/png', 'image/gif', 'image/jpeg', 'image/bmp').
       rejecting('text/plain', 'text/xml') }

  it { should_not allow_value('ex@mple').for(:profile_name) }
  it { should_not allow_value('ex.ample').for(:profile_name) }
  it { should_not allow_value('exam ple').for(:profile_name) }

  it { should_not allow_value('"Fred Bloggs"@iana.org').for(:email) }
  it { should_not allow_value('"Doug \"Ace\" L."@iana.org').for(:email) }
  it { should_not allow_value('first.last@example.123').for(:email) }
  it { should_not allow_value('test@example').for(:email) }
  it { should_not allow_value('"Ima Fool"@iana.org').for(:email) }
  it { should_not allow_value('email@111.222.333.44444').for(:email) }

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
    friendship = create(:blocked_user_friendship)
    expect(friendship.user.has_blocked?(friendship.friend)).to be true
  end

  it '#create_activity for status' do
    status = build(:status)

    expect{user.create_activity(status, 'created')}.to change(Activity, :count).by(1)
  end

  it '#create_activity for album' do
    album = build(:album)

    expect{user.create_activity(album, 'created')}.to change(Activity, :count).by(1)
  end
end
