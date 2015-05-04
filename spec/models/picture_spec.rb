require 'rails_helper'

describe Picture do
  it { should belong_to(:user) }
  it { should belong_to(:album) }

  it { should validate_presence_of(:album_id) }
  it { should validate_attachment_presence(:asset) }
  it { should validate_attachment_content_type(:asset).
       allowing('image/png', 'image/gif', 'image/jpeg', 'image/bmp').
       rejecting('text/plain', 'text/xml') }
end
