class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :token

  def id
    object.encrypted_id
  end

  def  token
    object.authentication_token
  end
end
