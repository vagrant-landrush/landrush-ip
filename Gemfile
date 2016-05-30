source 'https://rubygems.org'
gemspec

group :plugins do
  gem 'landrush-ip', path: '.'
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
end
