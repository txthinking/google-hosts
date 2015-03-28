//
// get ip range from CIDR
// Author: cloud@txthinking.com
//

package main

import (
    "bitbucket.org/txthinking/util"
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
    c, err := util.CIDR(os.Args[1])
    if err != nil{
        Usage()
    }
    f, _ := util.IP2Decimal(c.First)
    l, _ := util.IP2Decimal(c.Last)
    fmt.Printf("%d\t%d\n", f, l)
}
