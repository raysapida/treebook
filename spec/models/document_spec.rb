require 'rails_helper'

describe Document do
  it { should have_attached_file(:attachment) }
  it { should validate_attachment_size(:attachment).less_than(5.megabytes) }
  it { should validate_attachment_content_type(:attachment).
       allowing('image/png', 'image/gif', 'image/jpeg', 'image/bmp').
       rejecting('text/plain', 'text/xml') }
end
