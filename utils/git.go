package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"path"
	"path/filepath"
	"strings"
)

func GetAllParentDirs(path string) []string {
	var result []string

	root, _ := filepath.Abs(path)
	split := strings.Split(root, "/")
	for i := len(split); i > 1; i-- {
		result = append(result, strings.Join(split[0:i], "/"))
	}
	return result
}

// Return the head ref of the directory or empty if there is none
func GetHeadRef(root string) string {
	f := path.Join(root, ".git", "HEAD")
	data, err := ioutil.ReadFile(f)
	if err != nil {
		return ""
	}
	return string(data)
}

func main() {
	if len(os.Args) >= 2 && os.Args[1] == "rev-parse" {
		os.Exit(3)
	}

	if len(os.Args) < 2 || os.Args[1] != "symbolic-ref" {
		fmt.Println("This is not the real GIT!")
		return
	}

	dirs := GetAllParentDirs(".")
	var head string
	for _, dir := range dirs {
		head = GetHeadRef(dir)
		if head != "" {
			break
		}
	}

	if len(head) > 5 && head[0:5] == "ref: " {
		fmt.Print(head[5:])
	} else if len(head) > 7 {
		fmt.Println(head[:7])
	} else {
		os.Exit(2)
	}
}
