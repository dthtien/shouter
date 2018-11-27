class AddFollowingCouterCachesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :followings_count, :integer, default: 0, null: false
    add_column :users, :followers_count, :integer, default: 0, null: false
    
    User.find_each do |user|
      User.update_counters(
        user.id, 
        followings_count: user.followings.count,
        followers_count: user.followers.count
      )
    end
  end
end
