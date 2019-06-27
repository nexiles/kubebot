package main

import (
	"log"
	"io/ioutil"
	"os"
	"os/exec"
	"strings"
)

func execute(name string, arg ...string) string {
	rescueStdout := os.Stdout
	r, w, _ := os.Pipe()
	os.Stdout = w
	os.Stderr = w

	log.Printf("execute: command: '%s %s'", name, strings.Join(arg, " "))

	cmd := exec.Command(name, arg...)
	stdin, err := cmd.StdinPipe()

	if err != nil {
		log.Printf("Error: StdinPipe:", err)
		return ""
	}

	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err = cmd.Start(); err != nil {
		log.Println("Error: cmd.Start(): ", err)
	}

	_ = stdin.Close()

	log.Println("waiting for command to exit ...")
	_ = cmd.Wait()
	_ = w.Close()

	out, _ := ioutil.ReadAll(r)
	os.Stdout = rescueStdout

	return string(out)
}
