class Api::UsersController < Api::BaseController

  def sign_up
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: {errors: @user.errors.full_messages}, status: :not_acceptable
    end
  end

  def sign_in
    @user = User.find_by_email(params[:email])

    if @user && @user.valid_password?(params[:password])
      render json: @user
    else
      render json: {errors: I18n.t("error.username_or_password_not_match")}, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :nickname)
  end

end
