class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  enum status: [:active, :done, :discard]
  after_update :update_activity

  private

  def update_activity
    Activity.create(user_id: user_id, target_type: "Task", target_id: task_id, status: status)
  end
end
