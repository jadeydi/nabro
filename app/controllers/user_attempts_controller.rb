class UserAttemptsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @user_attempts = UserAttempt.includes([:user, :attempt]).order(updated_at: :desc).limit(50)
  end

  def create
    count = current_user.attempts.where(status: 0).count
    if count > 0
    a = current_user.attempts.where(status: 0).offset(rand(count)).first
    current_user.user_attempts.create(attempt_id: a.id)
    current_user.update_last_clicked_at
    redirect_to root_url
    else
      redirect_to attempts_url
    end
  end

  def done
    current_user.user_attempts.find(params[:id]).done!
    redirect_to root_url
  end

  def discard
    current_user.user_attempts.find(params[:id]).discard!
    redirect_to root_url
  end
end
