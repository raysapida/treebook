require 'rails_helper'

describe UserFriendship do
  it { should belong_to(:user) }
  it { should belong_to(:friend) }

  it 'allow UserFriendships to be created' do
    user = create(:user)
    friend = create(:user)

    friendship = UserFriendship.request(user, friend)
    friendship2 = UserFriendship.last

    expect(friendship[:state]).to eq('pending')
    expect(friendship2[:state]).to eq('requested')
  end

  it 'allow UserFriendship to accept' do
    user = create(:user)
    friend = create(:user)

    friendship = UserFriendship.request(user, friend)
    friendship.accept

    expect(friendship[:state]).to eq('accepted')
  end

  it 'allow UserFriendship to block' do
    user = create(:user)
    friend = create(:user)

    friendship = UserFriendship.request(user, friend)
    friendship.block

    expect(friendship[:state]).to eq('blocked')
  end
end
