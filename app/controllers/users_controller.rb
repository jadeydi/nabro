class UsersController < ApplicationController
  before_action :authenticate_user!

  def update_avatar
    if request.post?
      current_user.avatar_url = params[:avatar]
      current_user.save
      redirect_to :update_avatar_users
    else
      render :update_avatar
    end
  end

end
