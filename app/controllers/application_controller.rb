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

  def generate_activation_token
    a = ('a'..'z').to_a.shuffle.first(10).join
    b = ('0'..'9').to_a.shuffle.first(10).join
    token = a + b
    token
  end
end
