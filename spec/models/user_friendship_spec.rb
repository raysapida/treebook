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

  it 'allow UserFriendship to be destroyed' do
    pending('Cannot delete from model, may need controller to verify user')
    user = create(:user)
    friend = create(:user)

    friendship = UserFriendship.request(user, friend)
    friendship.save
    friendship.delete
    friendship.save

    expect(friendship).to be_nil
  end
end
