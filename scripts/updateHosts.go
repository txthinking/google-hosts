//
// update hosts for windows
// cloud@txthinking.com
// date 2013-03-15
//
package main

import (
    "os"
    "io"
    "bufio"
    "strings"
    "net/http"
    "time"
)

const (
    HOSTS_PATH string = os.Getenv("SYSTEMROOT")+"\\system32\\drivers\\etc\\hosts"
    SEARCH_STRING string = "#TX-HOSTS"
    HOSTS_SOURCE string = "http://tx.txthinking.com/hosts"
)

func main(){
    var hosts string
    f, _ := os.OpenFile(HOSTS_PATH, os.O_RDONLY, 0444)
    bnr := bufio.NewReader(f)
    for{
        line, err := bnr.ReadString('\n')
        if strings.Contains(line, SEARCH_STRING) {
            break
        }
        hosts += line
        if err==io.EOF {
            break
        }
    }
    f.Close();
    hosts += "\r\n"
    hosts += SEARCH_STRING
    hosts += "\r\n"

    res, err := http.Get(HOSTS_SOURCE)
    if err != nil{
        println(err.Error())
        time.Sleep(3 * time.Second)
        return
    }
    bnr = bufio.NewReader(res.Body)
    for{
        line, err := bnr.ReadString('\n')
        hosts += line[0:len(line)-1] + "\r\n"
        if err==io.EOF {
            break
        }
    }

    os.Rename(HOSTS_PATH, HOSTS_PATH+".BAK")
    f, _ = os.OpenFile(HOSTS_PATH, os.O_WRONLY|os.O_CREATE, 0644)
    f.WriteString(hosts);
    println("Success! Will close after 3 seconds.")
    time.Sleep(3 * time.Second)
}

