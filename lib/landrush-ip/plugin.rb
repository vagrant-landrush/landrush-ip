module LandrushIp
  class Plugin < Vagrant.plugin('2')
    name 'LandrushIp'

    description <<-DESC
      This plugin allows for finer grained control over which IP to use as external address.
      Particularly when you use DHCP and have multiple interfaces (virtual or otherwise) this often is a problem.
    DESC

    config(:landrush_ip) do
      require 'landrush-ip/config'
      Config
    end

    guest_capability('linux', 'landrush_ip_installed') do
      require 'landrush-ip/cap/linux/landrush_ip_installed'
      Cap::Linux::LandrushIpInstalled
    end

    guest_capability('linux', 'landrush_ip_install') do
      require 'landrush-ip/cap/linux/landrush_ip_install'
      Cap::Linux::LandrushIpInstall
    end

    guest_capability('linux', 'landrush_ip_get') do
      require 'landrush-ip/cap/linux/landrush_ip_get'
      Cap::Linux::LandrushIpGet
    end

    require 'landrush-ip/action/install'

    %w(up reload).each do |action|
      action_hook(:landrush_ip, "machine_action_#{action}".to_sym) do |hook|
        hook.before(Landrush::Action::RedirectDns, Action::Install, :provision)
      end
    end
  end
end
