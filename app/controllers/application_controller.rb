class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  # added section but might not be needed for new devise version
  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

  def configure_permitted_parameters
    registration_params = [:first_name, :last_name, :profile_name, :email, :password, :password_confirmation, :avatar]
    devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)
    devise_parameter_sanitizer.permit(:account_update, keys: registration_params + [:current_password])
  end

  def render_404
    render file: 'public/404', status: :not_found
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.try(:is_admin?)
  end

  def authorize
    if current_user.is_admin?
      Rack::MiniProfiler.authorize_request
    end
  end
end
