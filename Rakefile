# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

Dir['tasks/**/*.rake'].each { |file| load(file) }

RSpec::Core::RakeTask.new(:spec)

task default: [:css, :js, :generate_spec_app, :spec]

# ensure fresh assets are included when packaging the gem
task build: %i[css js]
