class State < ActiveRecord::Base
  belongs_to :user

  after_create :generate_user_attempt

  private

  def generate_user_attempt
    UserAttempt.create(user_id: user_id, attempt_id: Attempt.rand_attempt.id)
  end
end
