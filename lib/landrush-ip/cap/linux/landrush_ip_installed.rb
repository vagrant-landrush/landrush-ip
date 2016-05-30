require 'landrush-ip/version'

module LandrushIp
  module Cap
    module Linux
      module LandrushIpInstalled
        def self.landrush_ip_installed(machine)
          result = ''
          machine.communicate.execute(command) do |type, data|
            result << data if type == :stdout
          end

          result.strip! == LandrushIp::VERSION
        end

        def self.command
          '/usr/local/bin/landrush-ip -v || echo 0'
        end
      end
    end
  end
end
