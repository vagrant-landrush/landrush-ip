$LOAD_PATH.push(File.expand_path('../../lib', __FILE__))

require 'bundler/setup'
require 'minitest/spec'

require 'landrush-ip'
require 'landrush-ip/version'
require 'landrush-ip/cap/linux/landrush_ip_installed'
require 'landrush-ip/cap/linux/landrush_ip_install'
require 'landrush-ip/cap/linux/landrush_ip_get'

require 'minitest/autorun'
require 'mocha/mini_test'

require 'yaml'

require 'mock/config'
require 'mock/provider'
require 'mock/communicator.rb'
require 'mock/ui'

def mock_output
  file     = File.open(File.expand_path('../mock/data.yml', __FILE__), 'r')
  contents = file.read
  file.close

  contents
end

def mock_data
  YAML.load(mock_output)
end

def mock_environment(options = { enabled: true })
  { machine: mock_machine(options), ui: Ui }
end

def mock_machine(options = {})
  env     = options.fetch(:env, Vagrant::Environment.new)
  machine = Vagrant::Machine.new(
    'mock_machine',
    'mock_provider',
    Mock::Provider,
    'provider_config',
    {},
    env.vagrantfile.config, # config
    Pathname('data_dir'),
    'box',
    options.fetch(:env, Vagrant::Environment.new),
    env.vagrantfile
  )

  machine.instance_variable_set('@communicator', Mock::Communicator.new)
  machine
end

module MiniTest
  class Spec
    alias hush capture_io
  end
end
