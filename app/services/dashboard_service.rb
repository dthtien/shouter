class DashboardService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def timeline
    TimelineService.new(timeline_users, scope)
  end

  private

  def scope
    @scope ||= if hashtag.present?
      SearchService.new(term: params[:hashtag]).results
    else
      Shout
    end
  end

  attr_reader :user, :params

  def timeline_users
    user.followings + [user]
  end

  def hashtag
    params[:hashtag]
  end
end
