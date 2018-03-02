source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.4"

gem "bootstrap-sass"
gem "coffee-rails", "~> 4.2"
gem "devise"
gem "filterrific"
gem "haml"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "pg", "~> 0.18"
gem "popper_js"
gem "puma", "~> 3.7"
gem "rails_12factor"
gem "sass-rails", "~> 5.0"
gem "therubyracer", platforms: :ruby
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "will_paginate"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
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

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
