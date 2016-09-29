Feature: landrush-ip-linux
  Landrush should pick the desired IP, given multiple network interfaces.

  Scenario Outline: booting a box and running the utility
    Given a file named "Vagrantfile" with:
    """
    Vagrant.configure('2') do |config|
      config.vm.box = '<box>'
      config.vm.guest = :windows
      config.vm.hostname = 'landrush-ip-acceptance-test'
      config.winrm.username = 'vagrant'
      config.winrm.password = 'vagrant'
      config.winrm.retry_delay = 30

      config.vm.network :private_network, ip: '192.168.50.50'

      config.vm.synced_folder '.', '/vagrant', disabled: true

      config.landrush_ip.auto_install = true
    end
    """
    When I successfully run `bundle exec vagrant up --provider <provider>`
    Then the WinRM command "C:\\landrush-ip.exe" should return some output containing "192.168.50.50"

    Examples:
      | box                                      | provider   |
      | opentable/win-2012r2-standard-amd64-nocm | virtualbox |
