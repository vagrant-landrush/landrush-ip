// go:generate
package main

import (
    "flag"
    "fmt"
    "net"
    "os"
    "encoding/json"
    "gopkg.in/yaml.v2"
)

// Type to hold a list of interfaces (strings)
type SimpleInterface struct {
    Name string `json:"name",yaml:"name"`
    IPv4 string `json:"ipv4",yaml:"ipv4"`
    IPv6 string `json:"ipv6",yaml:"ipv6"`
}

var (
    showVersion bool
    showHelp bool
    outputJson bool
    outputYaml bool
)

func init() {
    flag.Usage = func() {
        fmt.Println("Usage: landrush-ip [options]")
        fmt.Println("")
        fmt.Println("  Default output is a newline separated list of tab separated entries.")
        fmt.Println("  Each entry consists of name, IPv4 address, IPv6 address.")
        fmt.Println("")

        flag.PrintDefaults()

        os.Exit(0)
    }

    flag.BoolVar(&showVersion, "v", false, "Show version")
    flag.BoolVar(&showHelp, "h", false, "Show help")
    flag.BoolVar(&outputJson, "json", false, "Output in JSON format")
    flag.BoolVar(&outputYaml, "yaml", false, "Output in YAML format")
}

func fail(err error, msg string) {
    if err == nil {
        return
    }

    fmt.Printf("%s: %s", msg, err)
    os.Exit(1)
}

func main() {
    flag.Parse()
    if showVersion || showHelp {
        fmt.Println(Version)

        os.Exit(0)
    }

    ifaces, err := net.Interfaces()
    fail(err, "Unable to iterate network interfaces")

    result := []SimpleInterface{}

    for _, i := range ifaces {
        iface := SimpleInterface{
            Name: i.Name,
        }

        addrs, err := i.Addrs()
        if err != nil {
            fmt.Print(err)
            continue
        }

        for _, addr := range addrs {
            switch v := addr.(type) {
            case *net.IPNet:
                if v.IP.To4() != nil {
                    iface.IPv4 = v.IP.String()
                } else if v.IP.To16() != nil {
                    iface.IPv6 = v.IP.String()
                }

            case *net.IPAddr:
                if v.IP.To4() != nil {
                    iface.IPv4 = v.IP.String()
                } else if v.IP.To16() != nil {
                    iface.IPv6 = v.IP.String()
                }
            }
        }

        result = append(result, iface)
    }

    switch {
    case outputJson:
        data, err := json.Marshal(result)
        fail(err, "JSON error")

        fmt.Printf("%s", data)

    case outputYaml:
        data, err := yaml.Marshal(result)
        fail(err, "YAML error")

        fmt.Printf("%s", data)

    default:
        for _, i := range result {
            fmt.Printf("%s\t%s\t%s\n", i.Name, i.IPv4, i.IPv6)
        }
    }

    os.Exit(0)
}
