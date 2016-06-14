require 'landrush-ip/cap/windows'

module LandrushIp
  module Cap
    module Windows
      module LandrushIpInstall
        def self.determine_binary(uname)
          if uname =~ /(x64)/i
            'landrush-ip-windows_amd64.exe'
          elsif result =~ /(x86)/i
            'landrush-ip-windows_386.exe'
          else
            raise LandrushIp::Error, :unsupported_arch
          end
        end

        def self.landrush_ip_install(machine)
          result = ''
          machine.communicate.execute(command) do |type, data|
            result << data if type == :stdout
          end

          binary = determine_binary result

          machine.communicate.tap do |comm|
            host_path = File.expand_path("util/dist/#{binary}", LandrushIp.source_root)

            comm.upload(host_path, LandrushIp::Cap::Windows.binary_path)
          end
        end

        def self.command
          <<-CMD
            $Arch = "x64"
            if ("%PROCESSOR_ARCHITECTURE%" -eq "x86") {
              if (not defined PROCESSOR_ARCHITEW6432) {
                $Arch = "x86"
              }
            }
            Write-Host $Arch
            exit 0
          CMD
        end
      end
    end
  end
end
