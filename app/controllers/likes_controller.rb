class LikesController < ApplicationController
  before_action :set_shout

  def create
    current_user.like @shout
    redirect_to root_path
  end

  def destroy
    current_user.unlike! @shout
    redirect_to root_path
  end

  private

  def set_shout
    @shout ||= Shout.find(params[:id])
  end
end
