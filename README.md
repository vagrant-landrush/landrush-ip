# LandrushIp

This gem is a capability plugin for Vagrant, used in Landrush (but perfectly usable outside Landrush).

Its sole purpose is to provide a unified interface for grabbing a machine's IP addresses, independent of the OS.

While most operating systems do have multiple tools available to do this, they all work differently and none are standard across OS families.
 On Linux one might have `ip` or `ifconfig` for example.
 Neither is the de facto standard and in most cases, neither is installed by default in a minimal install.
  
To get around this, this plugin includes a tiny binary written in Go, that produces identical output on every OS.
 Therefore, any OS that is supported by Go can be supported by this plugin.

## Operating System Support

Currently, only Linux is supported.
Once we're happy with the functionality and mechanics, this will be expanded to BSD, Windows and whatever else we can support.

## Usage

When used with Landrush, it will automatically be activated and install itself.

Without Landrush, one has to enable it explicitly via `landrush_ip.override` if auto-installation is desired.

Other plugins can use the provided capabilities to check if it is installed and/or install it.

Example config with VirtualBox to force installation:

```ruby
Vagrant.configure('2') do |config|
  config.vm.define 'mybox' do |machine|
    machine.vm.box = 'debian/jessie64'
    machine.vm.network 'private_network', type: 'dhcp'
    
    machine.landrush_ip.override = true
    
    machine.vm.provider :virtualbox do |provider, _|
      provider.memory = 512
      provider.cpus = 2
    end
  end
end
```

## Capabilities

This plugin exposes the following _Guest_ capabilities:

- `landrush_ip_installed` returns a boolean to indicate whether Landrush is installed and up to date with the installed version of the plugin.
- `landrush_ip_install` installs the binary.
- `landrush_ip_get` returns all IP addresses of the machine in an array of hashes. Each hash has the following structure: `{ 'name' => 'lo', 'ipv4' => '127.0.0.1', 'ipv6' => '::1' }`.

Do note that the IP addresses are returned as strings; they are not yet cast to `IPAddr` or any other form, this is left entirely up to the consumer.

## Binary

The binary will be installed in various locations:

- Linux: `/usr/local/sbin/landrush-ip`

It has the following options:

- `-h` displays the usage/help
- `-v` displays the version
- `-json` returns the output in JSON format
- `-yaml` returns the output in YAML format

By default, it returns the output in TSV (Tab Separated Values) format.
 First column is interface name, second is IPv4 address and third is IPv6 address.
 
The JSON and YAML formats output objects and hashes respectively, that have a `name`, `ipv4` and `ipv6` key.

No filtering is done with any of the formats, so any interface that has no assigned IP will still show up.
 It's left up to consumer to filter that out.
 Same goes for the order in which they are returned, they are returned as returned by the OS.
 
The following examples are all from OS X (Darwin)

Plain text (`landrush-ip`):
```
lo0	127.0.0.1	fe80::1
gif0
stf0
en0	192.168.0.102
en1
en2
fw0
p2p0
awdl0
bridge0
```

YAML (`landrush-ip -yaml`):
```yaml
- name: lo0
  ipv4: 127.0.0.1
  ipv6: fe80::1
- name: gif0
  ipv4: ""
  ipv6: ""
- name: stf0
  ipv4: ""
  ipv6: ""
- name: en0
  ipv4: 192.168.0.102
  ipv6: ""
- name: en1
  ipv4: ""
  ipv6: ""
- name: en2
  ipv4: ""
  ipv6: ""
- name: fw0
  ipv4: ""
  ipv6: ""
- name: p2p0
  ipv4: ""
  ipv6: ""
- name: awdl0
  ipv4: ""
  ipv6: ""
- name: bridge0
  ipv4: ""
  ipv6: ""
```

JSON (`landrush-ip -json`):
```json
[
  {"name":"lo0","ipv4":"127.0.0.1","ipv6":"fe80::1"},
  {"name":"gif0","ipv4":"","ipv6":""},
  {"name":"stf0","ipv4":"","ipv6":""},
  {"name":"en0","ipv4":"192.168.0.102","ipv6":""},
  {"name":"en1","ipv4":"","ipv6":""},
  {"name":"en2","ipv4":"","ipv6":""},
  {"name":"fw0","ipv4":"","ipv6":""},
  {"name":"p2p0","ipv4":"","ipv6":""},
  {"name":"awdl0","ipv4":"","ipv6":""},
  {"name":"bridge0","ipv4":"","ipv6":""}
]
```

## Development

After checking out the repo, run `bundle install` to install dependencies.
 Run `rake spec` to run the tests.

A `Vagrantfile` is present to run the plugin in if you so desire.
 Make sure to execute in context of the Gem bundle: `bundle exec vagrant <command>`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Werelds/landrush-ip.
 This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

