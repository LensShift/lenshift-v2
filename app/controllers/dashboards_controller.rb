class DashboardsController < ApplicationController
	before_action :authenticate_lens_shifter!
	  def show
	  	@profile = current_lens_shifter.profile

	  	if @profile.nil?
	  		redirect_to new_profile_path
	  	else
	  		render :show
	  	end
	  end
end
