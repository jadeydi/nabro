class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  protected

  def after_sign_in_path_for(resource)
    tasks_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :nickname
  end

  def layout_by_resource
    if devise_controller?
      "visitor"
    else
      "application"
    end
  end
end
