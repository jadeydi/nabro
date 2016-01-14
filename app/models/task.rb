class Task < ActiveRecord::Base
  enum status: [:active, :archived]
  belongs_to :user
  has_many :comments, as: :target

  validates :content, presence: true
  validate :tasks_count, on: :create
  before_save :generate_title

  def self.rand_task
    offset(rand(count)).first
  end

  private
  def generate_title
    self.title = content.truncate(36)
  end

  def tasks_count
    errors.add(I18n.t("activerecord.models.task"), I18n.t("task.max")) if Task.where(user_id: user_id).where(status: 0).count > 6
  end
end
