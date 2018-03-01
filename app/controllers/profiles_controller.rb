class ProfilesController < ApplicationController
	before_action :authenticate_lens_shifter!
  before_action :set_profile, only: [:edit, :update, :destroy]


  def new
    gon_mapquest_key
    if current_lens_shifter.profile.present?
      @profile = current_lens_shifter.profile
    else
      @profile = Profile.create(lens_shifter: current_lens_shifter)
    end
    gon.profile = @profile
  end

  def edit
  	gon_mapquest_key
    gon.profile = @profile
  end

  def create
    gon.profile = @profile
    if current_lens_shifter.profile.present?
      @profile = current_lens_shifter.profile.update_attributes(profile_params)
    else
      @profile = Profile.create(profile_params.merge(lens_shifter: current_lens_shifter))
    end
    respond_to do |format|
      if @profile.valid?
        format.html { redirect_to dashboard_path, notice: 'Well done! Your profile was successfully created.' }
        format.json { render json: @profile.to_json, status: :created }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    return render json: render_errors("Cannot find the profile"), status: :not_found if @profile.blank?
    return render json: render_errors("We can't update this because this profile doesn't seem to belong to you!"), status: :forbidden if @profile.lens_shifter != current_lens_shifter

  	respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to dashboard_path, notice: 'Thanks! your profile was successfully updated.' }
        format.json { render json: @profile.to_json, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    return render json: render_errors("Cannot find the profile"), status: :not_found if @profile.blank?
    return render json: render_errors("We can't update this because this profile doesn't seem to belong to you!"), status: :forbidden if @profile.lens_shifter != current_lens_shifter

  	@profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Your profile was successfully destroyed.' }
      format.json { head :no_content, notice: 'Your profile was successfully destroyed.' }
    end
  end

  private

  def set_profile
  	@profile = Profile.find(params[:id])
  end

  def profile_params
      params.require(:profile).permit(:first_name, :last_name, :birthdate,
        :ethnicity, :location, :address, :sector, :referral, :comment, :contact_consent, :avatar)
  end

  def gon_mapquest_key
  	gon.mapquest_key = ENV['MAPQUEST_API_KEY']
  end
end
