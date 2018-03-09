class GuidesController < ApplicationController
	before_action :authenticate_lens_shifter!
	
	def index
		@guides = Guide.published_before(Time.zone.now)
		@page_title = 'Guides'
		@page_description = 'Our compact practical guides distill the learnings from our library and streams into bite-size references that can be tangibly applied in daily work and conversations.'
		@page_keywords = 'guides, practical, social impact'
	end
end
