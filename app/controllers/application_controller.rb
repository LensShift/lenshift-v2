class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end
  
  private
  def authenticate_fellow!
	unless current_lens_shifter.try(:admin?)
		flash[:error] = "Sorry, this is a fellow only section"
		redirect_to root_path
	end
  end
end
