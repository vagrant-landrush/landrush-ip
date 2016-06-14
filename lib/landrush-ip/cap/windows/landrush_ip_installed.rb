require 'landrush-ip/version'
require 'landrush-ip/cap/windows'

module LandrushIp
  module Cap
    module Windows
      module LandrushIpInstalled
        def self.landrush_ip_installed(machine)
          result = ''
          machine.communicate.execute(command) do |type, data|
            result << data if type == :stdout
          end

          result.strip! == LandrushIp::VERSION
        end

        def self.command
          <<-CMD
            try {
              if(Get-Command #{LandrushIp::Cap::Windows.binary_path}){
                #{LandrushIp::Cap::Windows.binary_path} -v
                exit 0
              }
            } Catch {
              Write-Host "0"
              exit 0
            }
          CMD
        end
      end
    end
  end
end
