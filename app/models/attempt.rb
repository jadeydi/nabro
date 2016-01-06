class Attempt < ActiveRecord::Base
  enum status: [:active, :archived]
  belongs_to :user
  has_many :comments, as: :target

  validates :content, presence: true
  validate :attempts_count, on: :create
  before_save :generate_title

  def self.rand_attempt
    offset(rand(count)).first
  end

  private
  def generate_title
    self.title = content.truncate(36)
  end

  def attempts_count
    errors.add(I18n.t("activerecord.models.attempt"), I18n.t("attempt.max")) if Attempt.where(user_id: user_id).where(status: 0).count > 6
  end
end
