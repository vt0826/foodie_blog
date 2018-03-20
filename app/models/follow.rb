class Follow < ActiveRecord::Base
  belongs_to :follower, foreign_key: :follower_id, class_name: User
  belongs_to :followee, foreign_key: :followee_id, class_name: User

  validates :follower_id, :uniqueness => {:scope => :followee_id}
  validate :check_same_user

  def check_same_user
      errors.add(:follower, "can't follow yourself") if self.follower_id == self.followee_id
  end
end
