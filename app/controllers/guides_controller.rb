class GuidesController < ApplicationController
	
	def index
		@guides = Guide.published_before(Time.zone.now)
	end
end
