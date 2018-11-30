class TimelineService
  def initialize(users, scope = Shout)
    @users = users
    @scope = scope
  end

  def shouts
    @shout = scope
              .includes(:user, :content)
              .where(user_id: users)
              .order(created_at: :desc)
              .map do |shout|
                ShoutPresenter.new shout
              end
  end

  def to_partial_path
    'timelines/timeline'
  end

  private

  attr_reader :users, :scope
end