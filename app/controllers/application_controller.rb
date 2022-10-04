class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?


def after_sign_in_path_for(user)
  modalities_path(user)
end

# def authenticate!
#   if @current_user == user_admin 
#       authenticate_user_admin!
#   elsif @current_user == user_regular
#       authenticate_user_regular!
#   end
# end



protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
end