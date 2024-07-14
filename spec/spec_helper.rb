# frozen_string_literal: true

require_relative 'support/coverage'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('dummy/config/environment', __dir__)
require 'rspec/rails'
require 'selenium/webdriver'

Capybara.server = :puma, { Silent: true }

Capybara.register_driver :chrome do |app|
  $selenium_driver = Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara::Screenshot::Diff.driver = :vips
Capybara::Screenshot::Diff.fail_if_new = ENV['CI']
Capybara::Screenshot::Diff.tolerance = 0.01
Capybara::Screenshot.save_path = "#{__dir__}/screenshots"

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.before(:each, type: :system) do
    driven_by :chrome do |options|
      options.args << '--force-device-scale-factor=1'
    end
  end
  config.include Capybara::Screenshot::Diff
end
