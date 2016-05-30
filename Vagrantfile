# -*- mode: ruby -*-
# vi: set ft=ruby :

def setup(machine)
  # Add a DHCP network so we don't know its IP :P
  machine.vm.network 'private_network', type: 'dhcp'

  machine.vm.provider :virtualbox do |provider, _|
    provider.memory = 512
    provider.cpus   = 2
  end

  machine.landrush_ip.override = true
end

Vagrant.configure('2') do |config|
  config.vm.define 'landrush_ip-test-debian' do |machine|
    machine.vm.box = 'debian/jessie64'
    setup machine
  end
end
