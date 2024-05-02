class Fellow::TeamMembersController < ApplicationController
  before_action :authenticate_fellow!
  before_action :set_team_member, only: [:show, :edit, :update, :destroy]

  # GET /fellow/team_members
  # GET /fellow/team_members.json
  def index
    @team_members = TeamMember.all
  end

  # GET /fellow/team_members/1
  # GET /fellow/team_members/1.json
  def show
  end

  # GET /fellow/team_members/new
  def new
    @team_member = TeamMember.new
    gon.mapquest_key = ENV['MAPQUEST_API_KEY']
  end

  # GET /fellow/team_members/1/edit
  def edit
    gon.mapquest_key = ENV['MAPQUEST_API_KEY']
    gon.team_member = @team_member
  end

  # POST /fellow/team_members
  # POST /fellow/team_members.json
  def create
    @team_member = TeamMember.new(team_member_params)

    respond_to do |format|
      if @team_member.save
        format.html { redirect_to fellow_team_members_path, notice: 'Team member was successfully created.' }
        format.json { render :show, status: :created, location: @team_member }
      else
        format.html { render :new }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fellow/team_members/1
  # PATCH/PUT /fellow/team_members/1.json
  def update
    respond_to do |format|
      if @team_member.update(team_member_params)
        format.html { redirect_to fellow_team_members_path, notice: 'Team member was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_member }
      else
        format.html { render :edit }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fellow/team_members/1
  # DELETE /fellow/team_members/1.json
  def destroy
    @team_member.destroy
    respond_to do |format|
      format.html { redirect_to fellow_team_members_path, notice: 'Team member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_member
      @team_member = TeamMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_member_params
      params.require(:team_member).permit(:team_member, :name, :role, :function, :avatar, info: {})
    end
end
