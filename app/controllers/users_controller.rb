class UsersController < Clearance::UsersController
  def show
    @user = User.find(params[:id])
    @shouts = @user.shouts.map do |shout|
      ShoutPresenter.new shout
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
