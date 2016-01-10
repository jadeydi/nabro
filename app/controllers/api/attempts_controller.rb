class Api::AttemptsController < Api::BaseController
  before_action :set_attempt, only: [:show, :update]

  def index
    middle_attempts = current_user.attempts
    if params[:id].blank?
      @attempts = middle_attempts.order(:status).order(created_at: :desc).limit(30)
    else
      @attempts = middle_attempts.where('id < ?', params[:id]).where.not(status: 0).order(created_at: :desc).limit(30)
    end
    render json: @attempts
  end

  def show
    render json: @attempt, root: false
  end

  def create
    @attempt = current_user.attempts.new(attempt_params)
    if @attempt.save
      render json: @attempt
    else
      render json: {errors: @attempt.errors.full_messages}, status: :not_acceptable
    end
  end

  def update
    if @attempt.update(attempt_params)
      render json: @attempt
    else
      render json: {errors: @attempt.errors.full_messages}, status: :not_acceptable
    end
  end

  private

  def set_attempt
    @attempt = Attempt.find_by_encrypt_id(params[:id])
  end

  def attempt_params
    params[:attempt].permit(:content, :status)
  end
end
