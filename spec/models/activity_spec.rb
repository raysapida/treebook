require 'rails_helper'

describe Activity do
  it { should belong_to(:user) }
  it { should belong_to(:targetable) }
end
