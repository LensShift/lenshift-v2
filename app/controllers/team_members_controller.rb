class TeamMembersController < ApplicationController
  def index
  	gon.team_members = TeamMember.order(:name)
  end
end
