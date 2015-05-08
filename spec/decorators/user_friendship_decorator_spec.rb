require 'rails_helper'

describe UserFriendshipDecorator do
  describe '#sub_message' do
    let(:friend) { create(:user, first_name: 'Joe') }

    it 'with a pending user friendship' do
      friendship = create(:pending_user_friendship, friend: friend)
      decorator = UserFriendshipDecorator.decorate(friendship)

      expect(decorator.sub_message).to eq('Friend request pending.')
    end

    it 'with a accepted user friendship' do
      friendship = create(:accepted_user_friendship, friend: friend)
      decorator = UserFriendshipDecorator.decorate(friendship)

      expect(decorator.sub_message).to eq('You are friends with Joe.')
    end
  end

  describe '#friendship_state' do
    it 'with a pending user friendship' do
      friendship = create(:pending_user_friendship)
      decorator = UserFriendshipDecorator.decorate(friendship)

      expect(decorator.friendship_state).to eq('Pending')
    end

    it 'with a accepted user friendship' do
      friendship = create(:accepted_user_friendship)
      decorator = UserFriendshipDecorator.decorate(friendship)

      expect(decorator.friendship_state).to eq('Accepted')
    end

    it 'with a requested user friendship' do
      friendship = create(:requested_user_friendship)
      decorator = UserFriendshipDecorator.decorate(friendship)

      expect(decorator.friendship_state).to eq('Requested')
    end
  end
end
