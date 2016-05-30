module LandrushIp
  module Action
    class Install
      def initialize(app, env, hook)
        @app  = app
        @env  = env
        @hook = hook
      end

      def installed?
        @machine.guest.capability(:landrush_ip_installed)
      end

      def override?
        @machine.config.landrush_ip.override
      end

      def enabled?
        override? || (@machine.config.key('landrush') && @machine.config.landrush.enabled)
      end

      def install
        @env[:ui].warn I18n.t('vagrant.config.landrush_ip.not_installed')

        raise Vagrant::LandrushIp::Error, :cannot_install unless @machine.guest.capability(:landrush_ip_install)
      end

      def call(env)
        @app.call(env)
        @env = env
        @machine = env[:machine]

        # Auto install in one of 2 cases:
        # - landrush-ip is forcibly enabled via the override setting
        # - Landrush is installed and enabled
        install if enabled? && !installed?

        @env[:ui].info I18n.t('vagrant.config.landrush_ip.not_enabled') unless enabled?
      end
    end
  end
end
