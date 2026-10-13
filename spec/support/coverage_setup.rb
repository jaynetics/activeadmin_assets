return unless ENV['CI'] || ARGV.grep(/spec\.rb/).empty? # skip if running individual specs

require 'simplecov'
require 'simplecov-cobertura'

SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter if ENV['CI']
SimpleCov.start do
  skip 'spec'
  enable_coverage :branch
  primary_coverage :branch
end
SimpleCov.minimum_coverage line: 100, branch: 100
