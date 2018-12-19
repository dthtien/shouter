class TimelineService
  def initialize(users, scope = Shout)
    @users = users
    @scope = scope
  end

  def shouts
    @shout = scope.map{ |shout| ShoutPresenter.new shout }
  end

  def to_partial_path
    'timelines/timeline'
  end

  private

  attr_reader :users, :scope
end