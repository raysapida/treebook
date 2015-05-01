require "rails_helper"

RSpec.describe PicturesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/profilename/albums/1/pictures").to route_to(:controller => "pictures",
                                                                   :action => "index",
                                                                   :album_id => "1",
                                                                   :profile_name => "profilename")
    end

    it "routes to #new" do
      expect(:get => "/profilename/albums/1/pictures/new").to route_to(:controller => "pictures",
                                                                       :action => "new",
                                                                       :album_id => "1",
                                                                       :profile_name => "profilename")
    end

    it "routes to #show" do
      expect(:get => "/profilename/albums/1/pictures/1").to route_to(:controller => "pictures",
                                                                     :action => "show",
                                                                     :album_id => "1",
                                                                     :id => "1",
                                                                     :profile_name => "profilename")
    end

    it "routes to #edit" do
      expect(:get => "/profilename/albums/1/pictures/1/edit").to route_to(:controller => "pictures",
                                                                          :action => "edit",
                                                                          :album_id => "1",
                                                                          :id => "1",
                                                                          :profile_name => "profilename")
    end

    it "routes to #create" do
      expect(:post => "/profilename/albums/1/pictures").to route_to(:controller => "pictures",
                                                                    :action => "create",
                                                                    :album_id => "1",
                                                                    :profile_name => "profilename")
    end

    it "routes to #update" do
      expect(:put => "/profilename/albums/1/pictures/1").to route_to(:controller => "pictures",
                                                                     :action => "update",
                                                                     :album_id => "1",
                                                                     :id => "1",
                                                                     :profile_name => "profilename")
    end

    it "routes to #destroy" do
      expect(:delete => "/profilename/albums/1/pictures/1").to route_to(:controller => "pictures",
                                                                        :action => "destroy",
                                                                        :album_id => "1",
                                                                        :id => "1",
                                                                        :profile_name => "profilename")
    end

  end
end
