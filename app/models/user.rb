class User < ApplicationRecord
  include Clearance::User

  has_many :shouts
  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout

  validates :username, presence: true, uniqueness: true

  def like(shout)
    liked_shouts << shout
  end

  def unlike!(shout)
    Like.find_by(shout_id: shout.id, user_id: id).destroy
  end
end
