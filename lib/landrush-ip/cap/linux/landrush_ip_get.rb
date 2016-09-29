require 'yaml'
require 'landrush-ip/cap/linux'

module LandrushIp
  module Cap
    module Linux
      module LandrushIpGet
        def self.landrush_ip_get(machine)
          machine.guest.capability(:landrush_ip_install) unless machine.guest.capability(:landrush_ip_installed)

          result = ''
          machine.communicate.execute(command) do |type, data|
            result << data if type == :stdout
          end

          YAML.load(result)
        end

        def self.command
          "#{LandrushIp::Cap::Linux.binary_path} -yaml"
        end
      end
    end
  end
end
