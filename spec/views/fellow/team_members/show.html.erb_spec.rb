require 'rails_helper'

RSpec.describe "fellow/team_members/show", type: :view do
  before(:each) do
    @fellow_team_member = assign(:fellow_team_member, Fellow::TeamMember.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
