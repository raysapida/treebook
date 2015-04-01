require 'rails_helper'

describe User do
  it { should have_many(:statuses)  }
  it { should have_many(:friends)  }
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

  it 'has a valid factory' do
    user_factory = FactoryGirl.create(:user)
    expect(user_factory).to be_valid
  end
end
