class RelationsController < ApplicationController
  def follow
    current_user.follow! user
    redirect_to user
  end

  def unfollow
    current_user.unfollow! user
    redirect_to user
  end

  private

  def user
    @user ||= User.find_by_username(params[:id])    
  end
end
