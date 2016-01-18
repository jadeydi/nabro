class Api::TasksController < Api::BaseController
  before_action :set_task, only: [:show, :update]

  def index
    middle_tasks = current_user.tasks
    if params[:id].blank?
      @tasks = middle_tasks.order(:status).order(created_at: :desc).limit(30)
    else
      @tasks = middle_tasks.where('id < ?', params[:id]).where.not(status: 0).order(created_at: :desc).limit(30)
    end
    render json: @tasks
  end

  def show
    @comments = @task.comments.limit(1)

    render json: @task, with_comments: true, with_user: true
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      render json: @task
    else
      render json: {error: @task.errors.full_messages}, status: :not_acceptable
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: {error: @task.errors.full_messages}, status: :not_acceptable
    end
  end

  private

  def set_task
    @task = Task.find_by_encrypt_id(params[:id])
  end

  def task_params
    params[:task].permit(:content, :status)
  end
end
