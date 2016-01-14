class Api::AttemptsController < Api::BaseController
  def index
    @attempts = Attempt.includes([:user, :task]).order(updated_at: :desc).limit(50)

    render json: @attempts
  end

  def create
    count = current_user.tasks.where(status: 0).count
    if count > 0
      task = current_user.tasks.where(status: 0).offset(rand(count)).first
      @attempt = current_user.attempts.create(task_id: task.id)
      current_user.update_last_clicked_at
      render json: @attempt
    else
      render json: {}
    end
  end

  def done
    @attempt = current_user.attempts.find_by_encrypt_id(params[:id])
    @attempt.done!
    render json: @attempt
  end

  def discard
    @attempt = current_user.attempts.find_by_encrypt_id(params[:id])
    @attempt.discard!
    render json: @attempt
  end
end
