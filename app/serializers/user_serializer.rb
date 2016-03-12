class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :nickname, :token, :avatar, :biography, :last_clicked_at

  def id
    object.encrypted_id
  end

  def token
    object.authentication_token
  end

  def last_clicked_at
    object.last_clicked_at.to_s
  end
end
