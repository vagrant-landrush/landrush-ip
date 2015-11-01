landrush-ip
===========

This project was built to complement the [Landrush](https://github.com/phinze/landrush) plugin for [Vagrant](https://vagrantup.com)

Its only goal is to provide Landrush with a reliable cross-platform way of picking a usable IP for its DNS resolver.
Even between Linux distributions, there is no 100% consistent and reliable way of doing so.
Neither `ifconfig` nor `ip` are guaranteed to be present. With this simple binary we can get around that.

Usage
-----

```
landrush-ip [-exclude "regex"] [interface]
```

`-exclude` can be repeated as many times as you wish.

`interface` overrides any excludes however; if you specify the interface to fetch the IP for, only that will be looked up.

Examples:

```bash
# Exclude loopbox, VirtualBox adapters and any tunnel adapters
landrush-ip -exclude "lo[0-9]+" -exclude "vboxnet[0-9]+" -exclude ".*tun.*"

# Look up the IP for eth0
landrush-ip eth0
```

Building
--------

Just run `go build`. Cross compiling works fine with Go 1.5 too ;)
