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

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def user_params
    params[:user].permit(:nickname, :biography)
  end

end
