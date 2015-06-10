package main

import (
	"flag"
	"fmt"
	"net"
	"os"
)

func main() {
	var ifaces []net.Interface
	var err error

	flag.Parse()
	if len(flag.Args()) == 1 {
		iface, err := net.InterfaceByName(flag.Arg(0))
		if err != nil {
			fmt.Printf("No interface with name", flag.Arg(0))
			os.Exit(1)
		}

		ifaces = []net.Interface{*iface}
	} else {
		ifaces, err = net.Interfaces()
		if err != nil {
			fmt.Printf("Unable to iterate network interfaces")
			os.Exit(1)
		}
	}

	for _, i := range ifaces {
		addrs, err := i.Addrs()
		if err != nil {
			fmt.Print(err)
			continue
		}

		for _, addr := range addrs {
			switch v := addr.(type) {
			case *net.IPNet:
				if v.IP.To4() != nil {
					fmt.Printf("%s\n", v.IP.String())
				}
				break
			case *net.IPAddr:
				if v.IP.To4() != nil {
					fmt.Printf("%s\n", v.IP.String())
				}
				break
			}
		}
	}
}
