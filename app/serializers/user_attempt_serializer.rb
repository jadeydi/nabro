class UserAttemptSerializer < ActiveModel::Serializer
  attributes :id, :status, :created_at

  def id
    object.encrypted_id
  end

  def created_at
    object.created_at.to_s
  end

  belongs_to :user
  belongs_to :attempt
end
