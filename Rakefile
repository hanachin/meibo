# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

desc "Steep check"
task :steep do
  sh "steep", "check"
end

task default: %i[spec rubocop steep]
