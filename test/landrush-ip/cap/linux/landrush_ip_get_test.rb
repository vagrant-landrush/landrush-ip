require 'yaml'
require 'test_helper'

module LandrushIp
  module Cap
    module Linux
      describe LandrushIpGet do
        describe 'landrush_ip_get' do
          let(:machine) { mock_machine }

          it 'should return a hash' do
            machine.guest.capability(:landrush_ip_get).must_equal mock_data
          end
        end
      end
    end
  end
end
