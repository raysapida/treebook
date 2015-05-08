require 'rails_helper'

describe UserNotifier, type: :mailer do
  it 'should have access to URL helpers' do
    expect { login_url :host => 'example.com' }.not_to raise_error
    expect { login_url }.to raise_error
  end

  context '#friend_requested' do
    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      @friendship = create(:pending_user_friendship)
      UserNotifier.friend_requested(@friendship.id).deliver_now
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'should send an email' do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'renders the receiver email' do
      expect(ActionMailer::Base.deliveries.first.to).to eq([@friendship.friend.email])
    end

    it 'should set the subject to the correct subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq("#{@friendship.user.first_name} wants to be friends")
    end

    it 'renders the sender email' do  
      expect(ActionMailer::Base.deliveries.first.from).to eq(['from@example.com'])
    end
  end

  context '#friend_request_accepted' do
    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      @friendship = create(:pending_user_friendship)
      UserNotifier.friend_request_accepted(@friendship.id).deliver_now
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'should send an email' do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'renders the receiver email' do
      expect(ActionMailer::Base.deliveries.first.to).to eq([@friendship.user.email])
    end

    it 'should set the subject to the correct subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq("#{@friendship.friend.first_name} has accepted your friend request.")
    end

    it 'renders the sender email' do  
      expect(ActionMailer::Base.deliveries.first.from).to eq(['from@example.com'])
    end
  end

end
