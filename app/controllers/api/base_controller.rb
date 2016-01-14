class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :setup_user, :verify_user_from_token

  def index
    if Time.now.utc.to_date <= @user.last_clicked_at.to_date
      render json: @user.last_try
    else
      render json: {}
    end
  end

  private

  def setup_user
    @user ||= User.find_by_authentication_token(request.headers["X-Request-Id"])
    if @user && !user_signed_in?
      warden.set_user(@user)
    end
  end

  def verify_user_from_token
    render json: {}, status: 401 unless user_signed_in?
  end
end
