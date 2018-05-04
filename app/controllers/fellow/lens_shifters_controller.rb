class Fellow::LensShiftersController < ApplicationController
	before_action :authenticate_fellow!

	def index
		@lens_shifters = LensShifter.order(:id)
	end


	def export_csv
		lens_shifters = LensShifter.select(:id, :email, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :confirmed_at).joins(:profile)

		send_data lens_shifters.to_csv, filename: "lens-shifter-#{Date.today}.csv"
	end
end
