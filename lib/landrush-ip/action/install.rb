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

      def auto_install?
        @machine.config.landrush_ip.auto_install
      end

      def install
        @env[:ui].info I18n.t('vagrant.config.landrush_ip.not_installed')

        raise Vagrant::LandrushIp::Error, :cannot_install unless @machine.guest.capability(:landrush_ip_install)
      end

      def call(env)
        @app.call(env)
        @env = env
        @machine = env[:machine]

        # Auto install in one of 2 cases:
        # - landrush-ip is forcibly enabled via the auto_install setting
        # - Landrush is installed and enabled
        install if auto_install? && !installed?

        @env[:ui].info I18n.t('vagrant.config.landrush_ip.not_enabled') unless auto_install?
      end
    end
  end
end
