class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    render json: {success: "Hello API"}
  end
end
