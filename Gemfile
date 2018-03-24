source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.4"

gem 'activeadmin'
gem "active_admin_paranoia" , '~> 1.0.11'
gem "bootstrap-sass"
gem "carrierwave", "~> 1.0"
gem "coffee-rails", "~> 4.2"
gem "devise"
gem "filterrific"
gem 'google_drive'
gem "haml"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "mini_magick"
gem "pg", "~> 0.18"
gem "popper_js"
gem "puma", "~> 3.7"
gem "rails_12factor"
gem "rmagick"
gem "sass-rails", "~> 5.0"
gem 'sidekiq'
gem "sidekiq-cron", "~> 0.6.3"
gem 'sidekiq-client-cli'
gem "therubyracer", platforms: :ruby
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem 'whenever'
gem "will_paginate"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem 'rails-controller-testing'
  gem "rspec-rails", "~> 3.7"
  gem "selenium-webdriver"
  gem 'simplecov', require: false, group: :test
  gem "shoulda-matchers", "~> 3.1"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
