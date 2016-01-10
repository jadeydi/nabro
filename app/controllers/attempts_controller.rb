class AttemptsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_attempt, only: [:show, :edit, :update, :destroy]

  def index
    @attempts = current_user.attempts.order(:status).order(created_at: :desc).page(params[:page]).per(30)
  end

  def show
    @author = @attempt.user
    @comments = @attempt.comments.includes(:user).page(params[:page]).per(30)
  end

  def new
    @attempt = Attempt.new
  end

  def edit
  end

  def create
    @attempt = current_user.attempts.new(attempt_params)

    if @attempt.save
      redirect_to attempts_url
    else
      render :new
    end
  end

  def update
    if @attempt.update(attempt_params)
      redirect_to @attempt, notice: '要做更新成功'
    else
      render :edit
    end
  end

  def destroy
    @attempt.archived!
    redirect_to attempts_url, notice: 'Attempt was successfully destroyed.'
  end

  private
  def set_attempt
    @attempt = Attempt.find(params[:id])
  end

  def attempt_params
    params[:attempt].permit(:content)
  end
end
