# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }

# Prevent database truncation if the environment is production
if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!


  config.before :suite do
    FileUtils.mkdir(Rails.root.join("tmp/test/git"))

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed # load db seeds
  end

  config.after :suite do
    FileUtils.rm_rf(Rails.root.join("tmp/test/git"))
  end
end
