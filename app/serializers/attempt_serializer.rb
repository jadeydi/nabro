class AttemptSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :status, :created_at

  def id
    object.encrypted_id
  end

  def created_at
    object.created_at.to_s
  end
end
