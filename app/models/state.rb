class State < ActiveRecord::Base
  belongs_to :user

  after_create :generate_attempt

  private

  def generate_attempt
    Attempt.create(user_id: user_id, task_id: Task.rand_task.id)
  end
end
