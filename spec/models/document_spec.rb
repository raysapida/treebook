require 'rails_helper'

describe Document do
  it { is_expected.to respond_to(:attachment) }
end
