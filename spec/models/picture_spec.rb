require 'rails_helper'

describe Picture do
  it { should belong_to(:user) }
  it { should belong_to(:album) }
end
