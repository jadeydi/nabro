class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :setup_user, :verify_user_from_token

  def index
    if Time.now.utc.to_date <= current_user.last_clicked_at.to_date
      render json: current_user.last_try
    else
      render json: {}
    end
  end

  def current_user
    @current_user
  end

  def signed_in?
    !@current_user.nil?
  end

  private

  def setup_user
    @current_user ||= User.find_by_authentication_token(request.headers["X-Request-Id"])
  end

  def verify_user_from_token
    render json: {}, status: 401 unless signed_in?
  end
end
