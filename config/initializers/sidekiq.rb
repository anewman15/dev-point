Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' } if Rails.env.development?
  config.redis = { url: ENV['REDISTOGO_URL'] } if Rails.env.production?

  schedule_file = "config/schedule.yml"
  if File.exist?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' } if Rails.env.development?
  config.redis = { url: ENV['REDISTOGO_URL'] } if Rails.env.production?
end