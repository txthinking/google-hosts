//
// Update hosts for all OS
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
    "runtime"
    "fmt"
)

const (
    SEARCH_STRING string = "#TX-HOSTS"
    HOSTS_SOURCE string = "http://freedom.txthinking.com/hosts"
)

func Exit(message string){
    fmt.Println(message)
    time.Sleep(3 * time.Second)
    os.Exit(0)
}

func main(){
    BR := "\n"
    HOSTS_PATH := "/etc/hosts"
    if runtime.GOOS == "windows"{
        BR = "\r\n"
        HOSTS_PATH = os.Getenv("SYSTEMROOT")+"\\system32\\drivers\\etc\\hosts"
    }

    r, err := http.Get(HOSTS_SOURCE)
    if err != nil {
        Exit(err.Error() + "Try again.")
    }
    data, err := ioutil.ReadAll(r.Body)
    if err != nil {
        Exit(err.Error())
    }
    hosts := string(bytes.Replace(data, []byte("\n"), []byte(BR), -1))

    yours := ""
    f, err := os.OpenFile(HOSTS_PATH, os.O_RDONLY, 0444)
    if err == nil {
        bnr := bufio.NewReader(f)
        for{
            line, _, err := bnr.ReadLine()
            if bytes.Equal(line,[]byte(SEARCH_STRING)) || err == io.EOF{
                break
            }
            yours += string(line) + BR
        }
        err = f.Close()
        if err != nil {
            Exit(err.Error())
        }
        _ = os.Remove(HOSTS_PATH+".BAK")
        _ = os.Rename(HOSTS_PATH, HOSTS_PATH+".BAK")
    }
    yours += SEARCH_STRING + BR

    f, err = os.OpenFile(HOSTS_PATH, os.O_WRONLY|os.O_TRUNC|os.O_CREATE, 0644)
    if err != nil {
        Exit(err.Error())
    }
    _, err = f.WriteString(yours + hosts)
    if err != nil {
        Exit(err.Error())
    }
    err = f.Close()
    if err != nil {
        Exit(err.Error())
    }

    Exit("Success!")
}
