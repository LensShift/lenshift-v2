require "rails_helper"

RSpec.describe Fellow::StreamsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fellow/streams").to route_to("fellow/streams#index")
    end

    it "routes to #new" do
      expect(:get => "/fellow/streams/new").to route_to("fellow/streams#new")
    end

    it "routes to #edit" do
      expect(:get => "/fellow/streams/1/edit").to route_to("fellow/streams#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/fellow/streams").to route_to("fellow/streams#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fellow/streams/1").to route_to("fellow/streams#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fellow/streams/1").to route_to("fellow/streams#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fellow/streams/1").to route_to("fellow/streams#destroy", :id => "1")
    end

  end
end
