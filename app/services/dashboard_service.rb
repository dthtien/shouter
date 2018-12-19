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
    @scope = SearchService.new(term: "%##{hashtag}%").results if hashtag.present?
    @scope = SearchService.new(term: term).results if term.present?
    @scope ||= Shout.all
  end

  def timeline_users
    user.followings + [user]
  end

  def hashtag
    params[:term]
  end

  def term
    return unless params[:search].present?

    params[:search]['term']
  end
end
