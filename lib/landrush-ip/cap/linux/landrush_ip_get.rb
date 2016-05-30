require 'yaml'

module LandrushIp
  module Cap
    module Linux
      module LandrushIpGet
        def self.landrush_ip_get(machine)
          result = ''
          machine.communicate.execute(command) do |type, data|
            result << data if type == :stdout
          end

          YAML.load(result)
        end

        def self.command
          '/usr/local/bin/landrush-ip -yaml'
        end
      end
    end
  end
end
