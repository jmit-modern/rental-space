SIDEKIQ_REDIS_CONFIGURATION = {
  url: ENV["REDISTOGO_URL"] || ENV["REDIS_URL"] || "redis://localhost:6379/1", # if one assumes that REDIS_PROVIDER indirection is reliably present
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }, # we must trust Heroku and AWS here
}

# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = SIDEKIQ_REDIS_CONFIGURATION
end

Sidekiq.configure_client do |config|
  config.redis = SIDEKIQ_REDIS_CONFIGURATION
end
