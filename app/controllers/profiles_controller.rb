class ProfilesController < ApplicationController
	before_action :authenticate_lens_shifter!
  	before_action :set_profile, only: [:edit, :update, :destroy]

  def index
  	@profiles = Profile.all
  end

  def new
    gon_mapquest_key
    if current_lens_shifter.profile.present?
      @profile = current_lens_shifter.profile
    else
      @profile = Profile.create(lens_shifter: current_lens_shifter)
    end
  end

  def edit
  	gon_mapquest_key
    gon.profile = @profile
  end

  def create
    if current_lens_shifter.profile.present?
      @profile = current_lens_shifter.profile.update_attributes(profile_params)
    else
      @profile = Profile.create(profile_params.merge(lens_shifter: current_lens_shifter))
    end
    respond_to do |format|
      if @profile.valid?
        format.html { redirect_to dashboard_path, notice: 'Lens shifter profile was successfully created.' }
        format.json { render :dashboard, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  	respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to dashboard_path, notice: 'Lens shifter profile was successfully updated.' }
        format.json { render :dashboard, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Lens shifter profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_profile
  	@profile = Profile.find(params[:id])
  end

  def profile_params
      params.require(:profile).permit(:first_name, :last_name, :birthdate,
        :ethnicity, :location, :sector, :referral, :comment, :contact_consent)
  end

  def gon_mapquest_key
  	gon.mapquest_key = ENV['MAPQUEST_API_KEY']
  end
end
