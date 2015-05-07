//
// get ip range from CIDR
// Author: cloud@txthinking.com
//

package main

import (
    "github.com/txthinking/ant"
    "os"
    "fmt"
)

func Usage(){
    h := `
Usage:
    $ ./iprange 192.168.1.1/24
`
    fmt.Print(h)
    os.Exit(0)
}

func main(){
    if len(os.Args) != 2{
        Usage()
    }
    c, err := ant.CIDR(os.Args[1])
    if err != nil{
        Usage()
    }
    f, _ := ant.IP2Decimal(c.First)
    l, _ := ant.IP2Decimal(c.Last)
    fmt.Printf("%d\t%d\n", f, l)
}
