require 'test_helper'

describe 'LandrushIp::Config' do
  it 'supports enabling via accessor style' do
    machine = mock_machine
    config  = machine.config.landrush_ip

    machine.config.landrush_ip.override = true
    config.override?.must_equal true
    machine.config.landrush_ip.override = false
    config.override?.must_equal false
  end
end
