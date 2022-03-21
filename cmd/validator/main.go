package main

import (
	"fmt"
	_ "net/http/pprof"

	"github.com/rs/zerolog"
)

var logger zerolog.Logger

func main() {
	fmt.Println("vim-go")
}
