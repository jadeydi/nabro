class Task < ActiveRecord::Base
  enum status: [:active, :archived]
  belongs_to :user, counter_cache: true
  has_many :comments, as: :target

  validates :content, presence: true
  validate :tasks_count, on: :create
  before_save :generate_title
  after_create :generate_activity

  scope :quality, -> {where(quality: 1)}

  def self.rand_task
    offset(rand(count)).first
  end

  private
  def generate_title
    self.title = content.truncate(36)
  end

  def tasks_count
    errors.add(I18n.t("activerecord.models.task"), I18n.t("task.max")) if Task.where(user_id: user_id).where(status: 0).count > 1
  end

  def generate_activity
    Activity.create(user_id: user_id, target_type: "Task", target_id: id)
  end
end
