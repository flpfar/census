require_relative '../lib/census'
Dir[File.expand_path('../lib/census/workers/*.rb', File.dirname(__FILE__))].sort.each { |file| require file }

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://localhost:6379/1') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://localhost:6379/1') }
end
