class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_fellow!
  	return current_lens_shifter.admin?
  end
end
