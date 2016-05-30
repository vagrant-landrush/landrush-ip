require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

# Immediately sync all stdout
$stdout.sync = true
$stderr.sync = true

# Change to the directory of this file
Dir.chdir(File.expand_path('../', __FILE__))

# Rubocop
RuboCop::RakeTask.new

# Installs the tasks for gem creation
Bundler::GemHelper.install_tasks

# Tests
Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
  t.libs << 'test'
end

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

task :build => :build_binary

task default: [
  :rubocop,
  :test
]
