# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.7.2'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bootstrap', '5.0.0'
gem 'clearance'
gem 'image_processing', '~> 1.2'
gem 'jbuilder', '~> 2.7'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'redis', '~> 4.0'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'
# Track all changes related to model
gem 'audited'
# Render diffs between strings
gem 'diffy'
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'faker'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'database_cleaner-active_record', '~> 1.8.0'
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'webmock', '~> 3.8.3'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
