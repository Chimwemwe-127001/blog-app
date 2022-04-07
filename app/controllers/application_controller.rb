class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:Name, :Photo, :Bio, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :current_password) }
  end
end
