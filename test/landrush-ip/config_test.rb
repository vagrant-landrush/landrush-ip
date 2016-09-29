require 'test_helper'

describe 'LandrushIp::Config' do
  it 'supports enabling via accessor style' do
    machine = mock_machine
    config  = machine.config.landrush_ip

    machine.config.landrush_ip.auto_install = true
    config.auto_install?.must_equal true
    machine.config.landrush_ip.auto_install = false
    config.auto_install?.must_equal false
  end
end
