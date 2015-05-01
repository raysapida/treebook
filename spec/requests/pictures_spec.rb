require 'rails_helper'

RSpec.describe "Pictures", type: :request do
  describe "GET /pictures" do
    it "works! (now write some real specs)" do
      picture = create(:picture)
      get album_pictures_path(album_id: picture.album, profile_name: picture.album.user)
      expect(response).to have_http_status(200)
    end
  end
end
