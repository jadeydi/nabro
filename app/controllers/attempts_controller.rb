class AttemptsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_attempt, only: [:show, :edit, :update, :destroy]

  # GET /attempts
  def index
    @attempts = current_user.attempts.order(:status).page(params[:page]).per(30)
  end

  # GET /attempts/1
  def show
    @author = @attempt.user
    @comments = @attempt.comments.includes(:user).page(params[:page]).per(30)
  end

  # GET /attempts/new
  def new
    @attempt = Attempt.new
  end

  # GET /attempts/1/edit
  def edit
  end

  # POST /attempts
  def create
    @attempt = current_user.attempts.new(attempt_params)

    if @attempt.save
      redirect_to attempts_url
    else
      render :new
    end
  end

  # PATCH/PUT /attempts/1
  def update
    if @attempt.update(attempt_params)
      redirect_to @attempt, notice: '要做更新成功'
    else
      render :edit
    end
  end

  # DELETE /attempts/1
  def destroy
    @attempt.archived!
    redirect_to attempts_url, notice: 'Attempt was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attempt
      @attempt = Attempt.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def attempt_params
      params[:attempt].permit(:title, :content)
    end
end
