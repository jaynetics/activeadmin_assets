# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

Dir['tasks/**/*.rake'].each { |file| load(file) }

RSpec::Core::RakeTask.new(:spec)

task default: %i[build_assets generate_spec_app spec]

# ensure fresh assets are included when packaging the gem
Rake::Task[:build].enhance(%i[build_assets])
