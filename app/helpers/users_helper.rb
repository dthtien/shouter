module UsersHelper
  def user_action_link(user)
    if current_user.following? user
      link_to 'Unfollow', unfollow_user_path(user), method: :delete 
    else
      if current_user.can_following? user
        link_to 'Follow', follow_user_path(user), method: :post
      end
    end
  end
end
