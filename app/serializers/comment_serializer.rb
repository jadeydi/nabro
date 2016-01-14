class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at

  def id
    object.encrypted_id
  end

  def created_at
    object.created_at.to_s
  end

  belongs_to :user
end
