require 'rails_helper'

RSpec.describe "fellow/team_members/new", type: :view do
  before(:each) do
    assign(:fellow_team_member, Fellow::TeamMember.new())
  end

  it "renders new fellow_team_member form" do
    render

    assert_select "form[action=?][method=?]", fellow_team_members_path, "post" do
    end
  end
end
