class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  # prepend_before_filter :require_no_authentication, :only => [ :cancel]

  def after_sign_in_path_for(resource)
    case resource
      when Admin
        admin_admins_top_path
      when Client
      client_products_path(genre_sort: 0)
    end
  end

  def after_sign_out_path_for(resource)
    case resource
      when Admin
        "/admins/sign_in"
      when Client
        "'client/clients#top'"
  end
  end

  def price_include_tax(price)
    price = price * 1.1
    price.floor
  end


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:first_name, :last_name, :kana_first_name, :kana_last_name, :phone_number, :postal_code, :address])
  end

end
