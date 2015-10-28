class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname

  def id
    object.encrypted_id
  end
end
