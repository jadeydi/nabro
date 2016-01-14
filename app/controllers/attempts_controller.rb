class AttemptsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @attempts = Attempt.includes([:user, :task]).order(updated_at: :desc).limit(50)
  end

  def create
    count = current_user.tasks.where(status: 0).count
    if count > 0
      a = current_user.tasks.where(status: 0).offset(rand(count)).first
      current_user.attempts.create(task_id: a.id)
      current_user.update_last_clicked_at
      redirect_to root_url
    else
      redirect_to tasks_url
    end
  end

  def done
    current_user.attempts.find(params[:id]).done!
    redirect_to root_url
  end

  def discard
    current_user.attempts.find(params[:id]).discard!
    redirect_to root_url
  end
end
