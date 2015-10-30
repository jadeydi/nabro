class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user, except: [:index]

  def index
    render json: {success: "Hello API"}
  end

  private

  def authenticate_user
    @user = User.find_by_authentication(request.headers["Authorization"])
    if !user_signed_in?
      sign_in @user
    end
  end
end
