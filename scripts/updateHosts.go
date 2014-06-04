//
// @file updateHostsForWindows.go
// @brief fuck gfw
// @author cloud@txthinking.com
// @version 0.0.1
// @date 2013-03-15
//
package main

import (
    "os"
	"io"
    "bufio"
	"strings"
	"net/http"
)

const (
    HOSTS_PATH string = "C:\\windows\\system32\\drivers\\etc\\hosts"
	SEARCH_STRING string = "#TX-HOSTS"
	HOSTS_SOURCE string = "http://go.txthinking.com/hosts"
)

func main(){
	var hosts string
    f, _ := os.OpenFile(HOSTS_PATH, os.O_RDONLY, 0444)
    bnr := bufio.NewReader(f)
	for{
        line, err := bnr.ReadString('\n')
		if strings.Contains(line, SEARCH_STRING) || err==io.EOF {
			break
		}
		hosts += line
    }
	f.Close();
	hosts += "\n"
	hosts += SEARCH_STRING
	hosts += "\n"

	res, _ := http.Get(HOSTS_SOURCE)
    bnr = bufio.NewReader(res.Body)
	for{
        line, err := bnr.ReadString('\n')
		if err==io.EOF {
			break
		}
		hosts += line
    }

	os.Rename(HOSTS_PATH, HOSTS_PATH+"-BK-TX-HOSTS")
    f, _ = os.OpenFile(HOSTS_PATH, os.O_WRONLY|os.O_CREATE, 0644)
	f.WriteString(hosts);
	println("Success!")
}

