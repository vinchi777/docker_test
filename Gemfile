source 'https://rubygems.org'

gem 'rails', '~> 4.1.7'
# gem 'turbolinks'
gem 'tzinfo-data', platforms: [:mingw, :mswin]

gem 'mongoid', '~> 4.0.0'
gem 'devise', '~> 3.4.0'
gem 'cancancan'

gem 'simple_enum', '~> 2.0.0' , require: 'simple_enum/mongoid' # Enum for Mongoid

gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'

gem 'quiet_assets'

gem 'slim-rails'
gem 'best_in_place'

gem 'jbuilder', '~> 2.0'
gem 'will_paginate_mongoid', '~> 2.0.1'
gem 'wicked'

gem 'delayed_job_mongoid'

gem 'thin'

group :development do
  gem 'better_errors', '~> 1.1.0'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'spring'
  gem 'spring-commands-cucumber'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'simplecov', :require => false
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :heroku do
  # gem 'unicorn'
  # gem 'rack-timeout'
  # gem 'rack-handlers'
end	

gem 'rails_12factor', group: [:production, :heroku]
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development



