require 'rails_helper'

describe Picture do
  it { should belong_to(:user) }
  it { should belong_to(:album) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:album_id) }
end
