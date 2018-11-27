class User < ApplicationRecord
  include Clearance::User

  has_many :shouts

  has_many :likes

  has_many :liked_shouts, through: :likes, source: :shout

  has_many :following_relations,
    class_name: 'Relation',
    foreign_key: :follower_id

  has_many :follower_relations,
    class_name: 'Relation',
    foreign_key: :following_id

  has_many :followings, 
    through: :following_relations

  has_many :followers, 
    through: :follower_relations

  validates :username, presence: true, uniqueness: true

  def like(shout)
    liked_shouts << shout
  end

  def unlike!(shout)
    liked_shouts.destroy(shout)
  end

  def following?(user)
    following_ids.include?(user.id)
  end

  def can_following?(user)
    return false if user.id == id
    return false if following? user
    true
  end

  def follow!(user)
    return unless can_following? user
    followings << user
  end

  def unfollow!(user)
    followings.destroy(user)
  end

  def timeline_shouts
    Shout.where(user_id: following_ids + [id])
  end
  
  def to_param
    username
  end
end
