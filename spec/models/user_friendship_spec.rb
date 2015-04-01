require 'rails_helper'

describe UserFriendship do
  it { should belong_to(:user) }
  it { should belong_to(:friend) }
end
