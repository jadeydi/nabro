class Attempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  enum status: [:active, :done, :discard]
end
