class UserAttempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :attempt
  enum status: [:active, :done, :discard]
end
