class GuidesController < ApplicationController
	before_action :authenticate_lens_shifter!
	
	def index
		@guides = Guide.published_before(Time.zone.now)
	end
end
