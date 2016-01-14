class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status, :created_at, :comments

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
end
