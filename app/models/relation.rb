class Relation < ApplicationRecord
  belongs_to :following, 
    class_name: 'User',
    foreign_key: :following_id, 
    counter_cache: :followers_count

  belongs_to :follower, 
    class_name: 'User',
    foreign_key: :follower_id,
    counter_cache: :followings_count

  validates :following_id, uniqueness: {scope: :follower_id}
end
