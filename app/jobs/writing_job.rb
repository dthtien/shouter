class WritingJob < ApplicationJob
  queue_as :default

  def perform(shout_id)
    shout = ShoutPresenter.new(Shout.find(shout_id))

    send_to_channel(shout)
  end

  private

  def send_to_channel(shout)
    rendered_string = ApplicationController.render shout

    ActionCable.server.broadcast(
      'web_notifications_channel',
      message: rendered_string
    )
  end
end
