class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_fellow!
	unless current_lens_shifter.try(:admin?)
		flash[:error] = "Sorry, this is a fellow only section"
		redirect_to root_path
	end
  end
end
