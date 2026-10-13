# frozen_string_literal: true

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake'
require 'rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new('spec:progress') do |spec|
  spec.rspec_opts = %w[--format progress]
  spec.pattern = 'spec/**/*_spec.rb'
end

task default: :spec
