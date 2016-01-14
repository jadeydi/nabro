class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    if (t = params[:comment][:target_type].safe_constantize).blank?
      return :back
    end
    if (@target = t.find(params[:comment][:target_id]) rescue nil).blank?
      return :back
    end
    @comment = current_user.comments.new(comment_params.merge(target: @target))

    @comment.save
    redirect_to @target
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy if @comment.user_id == current_user.id
    redirect_to :back
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params[:comment].permit(:target_type, :target_id, :content)
    end
end
