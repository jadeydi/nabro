class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :recoverable and
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  GENDER = {'male': 0, 'female': 1}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = "#{auth.provider}+#{auth.uid}@imdull.com"
      user.password = Devise.friendly_token[0,20]
      user.nickname = auth.info.name
      user.avatar_url = auth.info.image
      user.gender = GENDER[auth.extra.raw_info.gender]
      user.profile_url = auth.extra.raw_info.link
    end
  end
end
