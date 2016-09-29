require 'vagrant'
require 'vagrant/errors'
require 'vagrant/util/template_renderer'

module LandrushIp
  class Config < Vagrant.plugin('2', :config)
    attr_accessor :override
    attr_accessor :auto_install

    DEFAULTS = {
      auto_install: false
    }.freeze

    def initialize
      @override = UNSET_VALUE
      @auto_install = UNSET_VALUE
      @logger   = Log4r::Logger.new('vagrantplugins::landruship::config')
    end

    def default_options(new_values = {})
      @default_options = DEFAULTS if @default_options == UNSET_VALUE
      @default_options.merge! new_values
    end

    def auto_install?
      # Keeping override for backward compatibility
      @auto_install || @override
    end

    def finalize!
      DEFAULTS.each do |name, value|
        if instance_variable_get('@' + name.to_s) == UNSET_VALUE
          instance_variable_set '@' + name.to_s, value
        end
      end
    end

    def validate(machine)
      if @override != UNSET_VALUE
        machine.env.ui.warn I18n.t('vagrant.config.landrush_ip.not_enabled')
      end

      nil
    end
  end
end
