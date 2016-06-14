# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'landrush-ip/version'

Gem::Specification.new do |spec|
  spec.name    = 'landrush-ip'
  spec.version = LandrushIp::VERSION
  spec.authors = ['Paul Werelds']
  spec.email   = ['paul@neverbland.com']
  spec.summary = <<-DESC
Capability plugin for Vagrant that allows more fine grained control over selecting IP addresses
  DESC
  spec.homepage      = 'https://github.com/Werelds/landrush-ip'
  spec.license       = 'MIT'
  spec.require_paths = ['lib']

  spec.files = Dir['lib/**/*.rb']
  spec.files += Dir['locales/*.yml']
  spec.files += Dir['util/dist/*']
  spec.files += %w(README.md LICENSE.txt CODE_OF_CONDUCT.md)

  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_development_dependency 'rake'
end
