class DashboardsController < ApplicationController
  def show
    @shout = Shout.new
    @shouts = Shout.newest.map do |shout|
      ShoutPresenter.new shout
    end
  end
end
