class Attempt < ActiveRecord::Base
  enum status: [:active, :archived]
  belongs_to :user
  has_many :comments, as: :target

  validates :content, presence: true
  before_save :generate_title

  def self.rand_attempt
    offset(rand(count)).first
  end

  private
  def generate_title
    self.title = content.truncate(36)
  end
end
