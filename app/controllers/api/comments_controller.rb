class Api::CommentsController < Api::BaseController
  def index
    @comments = current_user.comments.limit(30)
  end

  def show
    @comment = Comment.find_by_encrypt_id(params[:id])
    render json: @comment
  end

  def create
    if (klass = params[:comment][:target_type].safe_constantize).blank?
      return {}
    end
    if (@target = klass.find_by_encrypt_id(params[:comment][:target_id]) rescue nil).blank?
      return {}
    end
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: {error: @comment.errors.full_messages}, status: :not_acceptable
    end
  end

  def update
    @comment = current_user.comments.find_by_encrypt_id(params[:id])
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: {error: @comment.errors.full_messages}, status: :not_acceptable
    end
  end

  def destroy
    @comment = current_user.comments.find_by_encrypt_id(params[:id])
    @comment.destroy
    render json: {success: true}
  end

  private

  def comment_params
    params[:comment].permit(:content, :target_type, :target_id)
  end
end
