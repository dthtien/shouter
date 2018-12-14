class WritingJob < ApplicationJob
  queue_as :default

  def perform(shout_id)
    shout = Shout.find(shout_id)

    path = 'writing.rb'

    File.open(path, 'w+') do |f|
      f.write shout.content.body
    end
  end
end
