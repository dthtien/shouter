namespace :db do
  desc "Synchronize assets to S3"
  task reindex: :environment do
    Shout.reindex
  end
end