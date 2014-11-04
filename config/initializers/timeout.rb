# config/initializers/timeout.rb
if Rails.env.production? || Rails.env.heroku?
  Rack::Timeout.timeout = 10  # seconds
end