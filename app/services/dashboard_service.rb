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
    @scope ||= if params[:hashtag].present?
                Shout
                  .joins(text_shout_joinable_sql)
                  .where('text_shouts.body iLIKE ?', "%##{params[:hashtag]}%")
              else
                Shout
              end
  end

  attr_reader :user, :params

  def timeline_users
    user.followings + [user]
  end

  def text_shout_joinable_sql
    <<-SQL
      LEFT JOIN text_shouts
      ON shouts.content_id = text_shouts.id
      AND shouts.content_type = 'TextShout'
    SQL
  end
end
