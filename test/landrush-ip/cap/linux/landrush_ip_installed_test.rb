require 'test_helper'

module LandrushIp
  module Cap
    module Linux
      describe LandrushIpInstalled do
        describe 'landrush_ip_installed' do
          let(:machine) { mock_machine }

          it 'should return false when there is no output' do
            machine.communicate.stub_command(LandrushIp::Cap::Linux::LandrushIpInstalled.command, '')
            machine.guest.capability(:landrush_ip_installed).must_equal false
          end

          it 'should return false when version mismatches' do
            machine.communicate.stub_command(LandrushIp::Cap::Linux::LandrushIpInstalled.command, '99.99.99')
            machine.guest.capability(:landrush_ip_installed).must_equal false
          end

          it 'should return true when version matches' do
            machine.communicate.stub_command(LandrushIp::Cap::Linux::LandrushIpInstalled.command, LandrushIp::VERSION)
            machine.guest.capability(:landrush_ip_installed).must_equal true
          end
        end
      end
    end
  end
end
