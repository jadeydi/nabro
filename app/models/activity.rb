class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, polymorphic: true
  belongs_to :task
  enum status: [:fresh, :active, :done, :discard]
end
