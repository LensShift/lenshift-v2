require 'rails_helper'

RSpec.describe "fellow/team_members/edit", type: :view do
  before(:each) do
    @fellow_team_member = assign(:fellow_team_member, Fellow::TeamMember.create!())
  end

  it "renders the edit fellow_team_member form" do
    render

    assert_select "form[action=?][method=?]", fellow_team_member_path(@fellow_team_member), "post" do
    end
  end
end
