class Fellow::LensShiftersController < ApplicationController
	before_action :authenticate_fellow!

	def index
		@lens_shifters = LensShifter.order(:id)
	end


	def export_csv
		lens_shifters = LensShifter.joins(:profile).select(:id, :email, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :confirmed_at)

		send_data lens_shifters.to_csv, filename: "lens-shifters-#{Date.today}.csv"
	end

	def export_profile_csv
		lens_shifter_profiles = Profile.all

		send_data lens_shifter_profiles.to_csv, filename: "lens-shifter-profiles-#{Date.today}.csv"
	end
end
