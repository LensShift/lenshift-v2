class GuidesController < ApplicationController
	# before_action :authenticate_lens_shifter!
	
	def index
		@guides = Guide.published_before(Time.zone.now)
		@page_title = 'Guides'
		@page_description = 'Practical Guides distill the knowledge from our Library and Streams into bite-size references that can be tangibly applied in daily work and conversations.'
		@page_keywords = 'guides, practical, social impact'
	end
end
