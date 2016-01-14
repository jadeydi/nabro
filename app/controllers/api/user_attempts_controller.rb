class Api::UserAttemptsController < Api::BaseController
  def index
    @user_attempts = UserAttempt.includes([:user, :attempt]).order(updated_at: :desc).limit(50)

    render json: @user_attempts
  end

  def create
    count = current_user.attempts.where(status: 0).count
    if count > 0
      a = current_user.attempts.where(status: 0).offset(rand(count)).first
      @ua = current_user.user_attempts.create(attempt_id: a.id)
      current_user.update_last_clicked_at
      render json: @ua
    else
      render json: {}
    end
  end

  def done
    @ua = current_user.user_attempts.find_by_encrypt_id(params[:id])
    @ua.done!
    render json: @ua
  end

  def discard
    @ua = current_user.user_attempts.find_by_encrypt_id(params[:id])
    @ua.discard!
    render json: @ua
  end
end
