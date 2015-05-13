if Rails.env == 'development'
  require 'rack-mini-profiler'

  # initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)
  Rack::MiniProfiler.config.position = 'right'

  # Do not let rack-mini-profiler disable caching
  # Rack::MiniProfiler.config.disable_caching = false # defaults to true 
end

# set MemoryStore
# Rack::MiniProfiler.config.storage = Rack::MiniProfiler::MemoryStore
#
# set MemoryStore
# Rack::MiniProfiler.config.storage = Rack::MiniProfiler::MemoryStore
#
# # set RedisStore
# if Rails.env.production?
#   uri = URI.parse(ENV["REDIS_SERVER_URL"])
#   Rack::MiniProfiler.config.storage_options = { :host => uri.host, :port => uri.port, :password => uri.password }
#   Rack::MiniProfiler.config.storage = Rack::MiniProfiler::RedisStore
# end
#
# A hook in your ApplicationController
# def authorize
#   if current_user.is_admin?
#     Rack::MiniProfiler.authorize_request
#   end
# end
