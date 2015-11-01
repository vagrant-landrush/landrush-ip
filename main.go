package main

import (
	"flag"
	"fmt"
	"net"
	"os"
	"regexp"
)

// Type to hold a list of interfaces (strings)
type interfaces []string

// Required for flags
func (i *interfaces) String() string {
	return fmt.Sprintf("%s", *i)
}

// Adds a value to the array
func (i *interfaces) Set(value string) error {
	*i = append(*i, value)

	return nil
}

var (
	excluded interfaces
)

func init() {
	flag.Var(&excluded, "exclude", "List of interfaces to exclude")
}

func main() {
	var ifaces []net.Interface

	flag.Parse()
	if len(flag.Args()) == 1 {
		iface, err := net.InterfaceByName(flag.Arg(0))
		if err != nil {
			fmt.Printf("No interface with name", flag.Arg(0))
			os.Exit(1)
		}

		ifaces = []net.Interface{*iface}
	} else {
		allIfaces, err := net.Interfaces()
		if err != nil {
			fmt.Printf("Unable to iterate network interfaces")
			os.Exit(1)
		}

		if (len(excluded) == 0) {
			ifaces = allIfaces
		} else {
			var excludedRegex []regexp.Regexp

			for _, ex := range excluded {
				excludedRegex = append(excludedRegex, *regexp.MustCompile(ex))
			}

			for _, iface := range allIfaces {
				isExcluded := false
				for _, regex := range excludedRegex {
					isExcluded = isExcluded || regex.MatchString(iface.Name)
				}

				if !isExcluded {
					ifaces = append(ifaces, iface)
				}
			}
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
