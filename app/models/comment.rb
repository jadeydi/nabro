class Comment < ActiveRecord::Base
  belongs_to :target, polymorphic: true, counter_cache: true
  belongs_to :user

  validates :content, presence: true
end
