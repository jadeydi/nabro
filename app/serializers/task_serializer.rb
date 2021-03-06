class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status, :created_at, :comments_count, :likes_count, :comments, :user

  def id
    object.encrypted_id
  end

  def created_at
    object.created_at.to_s
  end

  def comments
    if options[:with_comments]
      object.comments.order(created_at: :desc).limit(30)
        .map {|c| ActiveModel::Serializer::Adapter::FlattenJson.new(CommentSerializer.new(c)).as_json}
    else
     []
    end
  end

  def user
    if options[:with_user]
      ActiveModel::Serializer::Adapter::FlattenJson.new(UserSerializer.new(object.user)).as_json
    else
      nil
    end
  end
end
