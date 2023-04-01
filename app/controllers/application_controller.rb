class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    if resource.businesses.size == 0
      stored_location_for(resource) || new_business_path
    else
      stored_location_for(resource) || business_path(resource.business.first)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :title])
  end
end
