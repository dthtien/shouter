class ShouterJob < ApplicationJob
  def perform(params, current_user_id)
    current_user = User.find(current_user_id)
    current_user.shouts.create(params)
  end
end
