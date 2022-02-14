package main

import (
	"fmt"
	"os"

	cpf "code.repo/cpf/src"
)

func main() {
	option := os.Args[1]
	inputCpf := os.Args[2]
	if option == "cdcpf" {
		fmt.Println(cpf.CalcularDigitosCpf(inputCpf))
	} else if option == "vcpf" {
		fmt.Println(cpf.VerificarCpf(inputCpf))
	} else {
		return
	}
}
