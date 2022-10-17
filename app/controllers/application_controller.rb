class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if user_path(current_user.id)
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to users_path(current_user.id)
    else
      render:after_sign_in_path_for
      flash[:notice] = "You have signed up error."
    end
  end

  def after_sign_out_path_for(resource)
    root_path
    flash[:notice] = "Signed out successfully."
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

