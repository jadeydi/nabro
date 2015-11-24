class Api::UsersController < Api::BaseController
  skip_before_action :verify_user_from_token, only: [:show, :sign_in, :sign_up]

  def show
    @user = User.find(User.decrypt_id(params[:id]))
    render json: @user
  end

  def update
    current_user.update_attributes(public_params)
    render json: current_user
  end

  def log_up
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: {errors: @user.errors.full_messages}, status: :not_acceptable
    end
  end

  def log_in
    @user = User.find_by_email(params[:email])

    if @user && @user.valid_password?(params[:password])
      render json: @user
    else
      render json: {errors: I18n.t("error.username_or_password_not_match")}, status: :unauthorized
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
