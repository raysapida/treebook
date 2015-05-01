require "rails_helper"

RSpec.describe AlbumsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/profilename/albums").to route_to(:controller => "albums",
                                                        :action => "index",
                                                        :profile_name => "profilename")
    end

    it "routes to #new" do
      expect(:get => "/profilename/albums/new").to route_to(:controller => "albums",
                                                            :action => "new",
                                                            :profile_name => "profilename")
    end

    it "routes to #show" do
      expect(:get => "/profilename/albums/1").to route_to(:controller => "albums",
                                                          :action => "show",
                                                          :id => "1",
                                                          :profile_name => "profilename")
    end

    it "routes to #edit" do
      expect(:get => "/profilename/albums/1/edit").to route_to(:controller => "albums",
                                                               :action => "edit",
                                                               :id => "1",
                                                               :profile_name => "profilename")
    end

    it "routes to #create" do
      expect(:post => "/profilename/albums").to route_to(:controller => "albums",
                                                         :action => "create",
                                                         :profile_name => "profilename")
    end

    it "routes to #update" do
      expect(:put => "/profilename/albums/1").to route_to(:controller => "albums",
                                                          :action => "update",
                                                          :id => "1",
                                                          :profile_name => "profilename")
    end

    it "routes to #destroy" do
      expect(:delete => "/profilename/albums/1").to route_to(:controller => "albums",
                                                             :action => "destroy",
                                                             :id => "1",
                                                             :profile_name => "profilename")

    end

  end
end
