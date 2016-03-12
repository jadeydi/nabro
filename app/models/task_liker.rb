class TaskLiker < ActiveRecord::Base
  belongs_to :user
  belongs_to :task, counter_cache: true
end
