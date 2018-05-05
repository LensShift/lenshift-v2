require 'rails_helper'

RSpec.describe "fellow/team_members/index", type: :view do
  before(:each) do
    assign(:fellow_team_members, [
      Fellow::TeamMember.create!(),
      Fellow::TeamMember.create!()
    ])
  end

  it "renders a list of fellow/team_members" do
    render
  end
end
