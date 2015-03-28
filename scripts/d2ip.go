//
// convert digital to ip
// Author: cloud@txthinking.com
//
package main

import (
    "os"
    "fmt"
    "strconv"
    "bitbucket.org/txthinking/util"
)

func Usage(){
    h := `
Usage:
    $ ./d2ip 3232235776
`
    fmt.Print(h)
    os.Exit(0)
}

func main(){
    if len(os.Args) != 2{
        Usage()
    }
    d, err := strconv.ParseInt(os.Args[1], 10, 64)
    if err != nil{
        Usage()
    }
    ip, err := util.Decimal2IP(d)
    if err != nil{
        Usage()
    }
    fmt.Printf("%s\n", ip)
}
