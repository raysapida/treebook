require 'rails_helper'

describe Album do
  it { should belong_to(:user) }
  it { should have_many(:pictures) }

  it { should validate_presence_of(:title) }
end
