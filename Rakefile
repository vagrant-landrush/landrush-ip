require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rake'
require 'rake/testtask'
require 'rake/clean'
require 'rubocop/rake_task'
require 'cucumber/rake/task'
require 'fileutils'

CLOBBER.include('pkg')
CLEAN.include('build')

task :init do
  FileUtils.mkdir_p 'build'
end

# Rubocop
RuboCop::RakeTask.new

# Installs the tasks for gem creation
Bundler::GemHelper.install_tasks

# Tests
Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
  t.libs << 'test'
end

# Cucumber acceptance test task
Cucumber::Rake::Task.new(:features)

# Builds the Go binary
task :build_binary do
  require 'landrush-ip/version'

  go_version = <<-DESC
package main

const Version string = "#{LandrushIp::VERSION}"
  DESC

  File.write('util/version.go', go_version)

  sh 'docker pull golang:1.6'
  sh 'docker run --rm -v $(pwd)/util:/usr/src/landrush-ip -w /usr/src/landrush-ip golang:1.6 make'
end

task features: :init

task build: :build_binary

task default: [
  :rubocop,
  :test
]
