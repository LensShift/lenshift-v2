class DashboardsController < ApplicationController
	before_action :authenticate_lens_shifter!
	  def show
	  	@lens_shifter_profile = current_lens_shifter.lens_shifter_profile
	  end
end
