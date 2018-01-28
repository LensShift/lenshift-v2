class LensShifterProfilesController < ApplicationController
  before_action :authenticate_lens_shifter!
  before_action :set_lens_shifter_profile, only: [:edit, :update, :destroy]

  def index
  	@lens_shifter_profiles = LensShifterProfile.all
  end

  def new
  	@lens_shifter_profile = LensShifterProfile.new
  end

  def edit
  end

  def create
  	@lens_shifter_profile = LensShifterProfile.new(lens_shifter_profile_params.merge(lens_shifter: current_lens_shifter ))

    respond_to do |format|
      if @lens_shifter_profile.save
        format.html { redirect_to @lens_shifter_profile, notice: 'Lens shifter profile was successfully created.' }
        format.json { render :show, status: :created, location: @lens_shifter_profile }
      else
        format.html { render :new }
        format.json { render json: @lens_shifter_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  	respond_to do |format|
      if @lens_shifter_profile.update(lens_shifter_profile_params)
        format.html { redirect_to @lens_shifter_profile, notice: 'Lens shifter profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @lens_shifter_profile }
      else
        format.html { render :edit }
        format.json { render json: @lens_shifter_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@lens_shifter_profile.destroy
    respond_to do |format|
      format.html { redirect_to lens_shifter_profiles_url, notice: 'Lens shifter profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_lens_shifter_profile
  	@lens_shifter_profile = LensShifterProfile.find(params[:id])
  end

  def lens_shifter_profile_params
      params.require(:lens_shifter_profile).permit(:first_name, :last_name, :birthdate,
        :ethnicity, :location, :sector, :referral, :comment, :contact_consent)
    end
end
