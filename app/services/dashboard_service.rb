class DashboardService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def timeline
    TimelineService.new(timeline_users, scope)
  end

  private

  attr_reader :user, :params

  def scope
    @scope ||= if hashtag.present?
                SearchService.new(term: "%##{hashtag}%").results
              else
                Shout
              end
  end

  def timeline_users
    user.followings + [user]
  end

  def hashtag
    params[:term]
  end

  def term
    return if params[:search].present?

    params[:search][:term]
  end
end
