class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include ActionView::Helpers::TextHelper
  
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

  def after_sign_out_path_for(scope)
    URI.parse(request.referer).path if request.referer
  end

  def after_sign_in_path_for(scope)
    resource_items_path
  end
end
