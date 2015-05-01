require 'rails_helper'

describe Status do
  it { should belong_to(:user) }
  it { should belong_to(:document) }
  it { should accept_nested_attributes_for(:document) }

  it { should validate_presence_of(:content)}
  it { should validate_presence_of(:user_id)}
  it { should validate_length_of(:content).is_at_least(2) }
end
