class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_task, only: [:show, :edit, :update, :archive, :destroy]

  def index
    @task = current_user.tasks.where(status: 0).last
    @tasks = current_user.tasks.where(status: 1).order(created_at: :desc).page(params[:page]).per(30)
  end

  def show
    @author = @task.user
    @comments = @task.comments.includes(:user).order(created_at: :desc).page(params[:page]).per(30)
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_url
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_url
    else
      render :edit
    end
  end

  def archive
    @task.update(task_params.merge({status: :archived}))
    redirect_to tasks_url
  end

  def destroy
    @task.archived!
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params[:task].permit(:content, :body)
  end
end
