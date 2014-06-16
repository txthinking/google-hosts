//
// Update hosts for windows
// cloud@txthinking.com
// date 2013-03-15
//
package main

import (
    "os"
	"io"
    "bufio"
	"net/http"
	"time"
	"bytes"
	"io/ioutil"
)

var (
    HOSTS_PATH string = os.Getenv("SYSTEMROOT")+"\\system32\\drivers\\etc\\hosts"
	SEARCH_STRING []byte = []byte("#TX-HOSTS")
	HOSTS_SOURCE string = "http://tx.txthinking.com/hosts"
)

func main(){
	var hosts []byte
    f, err := os.OpenFile(HOSTS_PATH, os.O_RDONLY, 0444)
	if err == nil {
		bnr := bufio.NewReader(f)
		for{
			line, _, err := bnr.ReadLine()
			if bytes.Compare(line,SEARCH_STRING)==0 || err == io.EOF{
				break
			}
			hosts = append(hosts, append(line,[]byte("\r\n")...)...)
		}
		f.Close()
	}
	hosts = append(hosts, append(SEARCH_STRING,[]byte("\r\n")...)...)

	res, err := http.Get(HOSTS_SOURCE)
	if err != nil {
		println(err.Error())
		time.Sleep(3 * time.Second)
		return
	}
    data, err := ioutil.ReadAll(res.Body)
	if err != nil {
		println(err.Error())
		time.Sleep(3 * time.Second)
		return
	}
	data = bytes.Replace(data, []byte("\n"), []byte("\r\n"), -1)
	hosts = append(hosts, data...)

	os.Rename(HOSTS_PATH, HOSTS_PATH+"-BAK-TX-HOSTS")
    f, err = os.OpenFile(HOSTS_PATH, os.O_WRONLY|os.O_CREATE, 0644)
	if err != nil {
		println(err.Error())
		time.Sleep(3 * time.Second)
		return
	}
	f.Write(hosts)
	println("Success!")
	time.Sleep(3 * time.Second)
}
