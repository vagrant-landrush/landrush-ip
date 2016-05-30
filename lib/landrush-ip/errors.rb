module LandrushIp
  class Error < Vagrant::Errors::VagrantError
    error_namespace('vagrant.config.landrush_ip.errors')
  end
end
