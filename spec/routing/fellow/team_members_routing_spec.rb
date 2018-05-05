require "rails_helper"

RSpec.describe Fellow::TeamMembersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fellow/team_members").to route_to("fellow/team_members#index")
    end

    it "routes to #new" do
      expect(:get => "/fellow/team_members/new").to route_to("fellow/team_members#new")
    end

    it "routes to #show" do
      expect(:get => "/fellow/team_members/1").to route_to("fellow/team_members#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fellow/team_members/1/edit").to route_to("fellow/team_members#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/fellow/team_members").to route_to("fellow/team_members#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fellow/team_members/1").to route_to("fellow/team_members#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fellow/team_members/1").to route_to("fellow/team_members#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fellow/team_members/1").to route_to("fellow/team_members#destroy", :id => "1")
    end

  end
end
