require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'


ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start "rails"

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

#Google Omniauth:
OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
  :info =>
    {:email =>"gthompson@fastmail.com",
     :first_name =>"Graham",
     :last_name =>"Thompson",
     :image =>"https://lh3.googleusercontent.com/-DOxXSdLajxg/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rc49PQDjVWUIprfzpDkZ27ZD2Fxvw/photo.jpg"},
  :credentials =>
    {:token => ENV["GOOGLE_TEST_TOKEN"]}
})

Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
