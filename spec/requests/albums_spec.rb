require 'rails_helper'

RSpec.describe "Albums", type: :request do
  describe "GET /albums" do
    it "works! (now write some real specs)" do
      album = create(:album)
      get albums_path(album.user)
      expect(response).to have_http_status(200)
    end
  end
end
