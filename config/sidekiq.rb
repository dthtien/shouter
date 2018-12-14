redis = {
  url:  ENV.fetch('REDIS_URL' ,'redis://localhost:6379/0'),
  namespace: ENV.fetch('REDIS_NAMESPACE', "shouter-#{Rails.env}")
}

Sidekiq.configure_client do |config|
  config.redis = redis
end

Sidekiq.configure_server do |config|
  config.redis = redis
end
