class Api::UsersController < Api::BaseController
  skip_before_action :verify_user_from_token, only: [:show, :sign_in, :sign_up, :reset_password]

  def show
    @user = User.find(User.decrypt_id(params[:id]))
    render json: @user
  end

  def me
    render json: current_user
  end

  def reset_password
    @user = User.find_by_email(params[:email])
    if @user
      @user.send_reset_password_instructions
      render json: {succuss: true}, status: :ok
    else
      render json: {error: "用户不存在"}, status: :not_found
    end
  end

  def update
    if current_user.update_attributes(public_params)
      render json: current_user
    else
      render json: {error: current_user.error.full_messages}, status: :not_acceptable
    end
  end

  def update_avatar
    current_user.avatar_url = params[:avatar]
    if current_user.save
      render json: current_user
    else
      render json: {error: "头像更新失败"}, status: :not_acceptable
    end
  end

  def sign_up
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: {error: @user.errors.full_messages}, status: :not_acceptable
    end
  end

  def sign_in
    @user = User.find_by_email(params[:email])

    if @user && @user.valid_password?(params[:password])
      warden.set_user(@user)
      render json: @user
    else
      render json: {error: I18n.t("error.username_or_password_not_match")}, status: :unauthorized
    end
  end

  private

  def public_params
    params[:user].permit(:nickname, :biography)
  end

  def user_params
    params.require(:user).permit(:email, :password, :nickname)
  end

end
