class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  GENDER = {'male': 0, 'female': 1}

  has_many :feelings

  before_create :init_last_clicked_at, :generate_authentication_token

  mount_uploader :avatar_url, AvatarUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = "#{auth.provider}+#{auth.uid}@imdull.com"
      user.password = Devise.friendly_token[0,20]
      user.nickname = auth.info.name
      user.avatar_url = auth.info.image
      user.gender = GENDER[auth.extra.raw_info.gender]
      user.profile_url = auth.extra.raw_info.link
      user.last_sign_in_at = 2.days.ago
    end
  end

  def update_last_clicked_at
    update_attribute :last_clicked_at, Time.now
  end

  def avatar
    avatar_url.url + "?imageView/1/w/200/h/200"
  end

  private

  def init_last_clicked_at
    self.last_clicked_at = 2.days.ago
  end

  def generate_authentication_token
    loop do
      token = SecureRandom.hex
      unless User.where(authentication_token: token).first
        self.authentication_token = token
        break
      end
    end
  end
end
