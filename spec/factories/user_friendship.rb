FactoryGirl.define do
  factory :user_friendship do
    association :user, factory: :user
    association :friend, factory: :user

    factory :pending_user_friendship do
      state 'pending'
    end

    factory :requested_user_friendship do
      state 'requested'
    end

    factory :accepted_user_friendship do
      state 'accepted'
    end
  end
end
