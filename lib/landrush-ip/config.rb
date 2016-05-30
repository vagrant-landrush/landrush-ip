require 'vagrant'
require 'vagrant/errors'
require 'vagrant/util/template_renderer'

module LandrushIp
  class Config < Vagrant.plugin('2', :config)
    attr_accessor :override

    DEFAULTS = {
      override: false
    }.freeze

    def initialize
      @override = UNSET_VALUE
      @logger   = Log4r::Logger.new('vagrantplugins::landruship::config')
    end

    def default_options(new_values = {})
      @default_options = {} if @default_options == UNSET_VALUE
      @default_options.merge! new_values
    end

    def override?
      @override
    end

    def finalize!
      @default_options = {} if @default_options == UNSET_VALUE
    end
  end
end
