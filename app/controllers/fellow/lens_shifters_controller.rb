class Fellow::LensShiftersController < ApplicationController
	before_action :authenticate_fellow!

	def index
		@lens_shifters = LensShifter.order(:id)
	end
end
