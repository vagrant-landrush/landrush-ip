source 'https://rubygems.org'
gemspec

group :plugins do
  gem 'vagrant-winrm'
  gem 'landrush-ip', path: '.'
  gem 'landrush', path: '../landrush'
end

group :test do
  gem 'rubocop', '~> 0.38.0'
end

group :development do
  gem 'vagrant',
      git: 'git://github.com/mitchellh/vagrant.git',
      ref: 'v1.8.1'

  gem 'byebug'
  gem 'mocha'
  gem 'minitest'
  gem 'cucumber', '~> 2.1'
  gem 'aruba', '~> 0.13'
  gem 'komenda', '~> 0.1.6'
end
