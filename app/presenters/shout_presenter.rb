class ShoutPresenter < ApplicationPresenter
  def username
    user.username
  end
  
  def body
  end

  def owner_email
    user.email
  end

  def liked_by?(user)
    user.liked_shout_ids.include? self.id
  end
end