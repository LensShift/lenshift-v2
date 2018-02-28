class DashboardsController < ApplicationController
	before_action :authenticate_lens_shifter!
	  def show
	  	profile = current_lens_shifter.profile.avatar
	  	gon.sectors = Profile::SECTORS
	  	gon_mapquest_key
	  	gon.avatar = current_lens_shifter.profile.avatar

	  	if profile.nil?
	  		flash[:notice] = "Oops, you don't seem to have a profile, shall we create one?"
	  		redirect_to new_profile_path
	  	else
	  		render :show
	  	end
	  end

	private

	def gon_mapquest_key
		gon.mapquest_key = ENV['MAPQUEST_API_KEY']
	end
end
