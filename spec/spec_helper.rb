# frozen_string_literal: true

require_relative 'support/coverage_setup'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('dummy/config/environment', __dir__)
require 'rspec/rails'
require_relative 'support/capybara_setup'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
