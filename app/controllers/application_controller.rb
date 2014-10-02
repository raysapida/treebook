class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	
	rescue_from ActiveRecord::RecordNotFound, with: :render_404
	
	# added section but might not be needed for new devise version
	before_action :configure_permitted_parameters, if: :devise_controller?
	

	
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :profile_name, :email, :password, :password_confirmation) }
  end  
	
	def render_404 
		render file: 'public/404', status: :not_found
	end
end
