class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def notify_admin
    flash[:success] = "New Advertisement created"
  end

end
