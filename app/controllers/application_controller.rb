class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  # prepend_before_filter :require_no_authentication, :only => [ :cancel] 

  def after_sign_in_path_for(resource)
    client_products_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end



  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:first_name, :last_name, :kana_first_name, :kana_last_name, :phone_number, :postal_code, :address])
  end

end
