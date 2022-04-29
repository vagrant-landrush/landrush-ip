require 'landrush-ip/cap/linux'

module LandrushIp
  module Cap
    module Linux
      module LandrushIpInstall
        def self.determine_binary(uname)
          if uname =~ /(x86_64|ia64|amd64)/i
            'landrush-ip-linux_amd64'
          elsif uname =~ /(arm)/i
            'landrush-ip-linux_arm'
          elsif uname =~ /(aarch64)/i
            'landrush-ip-linux_arm64'
          elsif uname =~ /(i386|i686)/i
            'landrush-ip-linux_386'
          else
            raise LandrushIp::Error, :unsupported_arch
          end
        end

        def self.landrush_ip_install(machine)
          result = ''
          machine.communicate.execute('uname -mrs') do |type, data|
            result << data if type == :stdout
          end

          binary = determine_binary result

          machine.communicate.tap do |comm|
            host_path  = File.expand_path("util/dist/#{binary}", LandrushIp.source_root)

            comm.upload(host_path, '/tmp/landrush-ip')
            comm.sudo("mv /tmp/landrush-ip #{LandrushIp::Cap::Linux.binary_path}")
            comm.sudo("chmod +x #{LandrushIp::Cap::Linux.binary_path}", error_check: false)
          end
        end
      end
    end
  end
end
