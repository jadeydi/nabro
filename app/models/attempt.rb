class Attempt < ActiveRecord::Base
  enum status: [:active, :archived]
  belongs_to :user

  validates :content, presence: true

  def self.rand_attempt
    offset(rand(count)).first
  end
end
