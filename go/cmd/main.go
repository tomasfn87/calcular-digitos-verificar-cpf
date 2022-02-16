package main

import (
	"fmt"
	"os"

	cpf "code.repo/cpf/src"
)

func main() {
	option := os.Args[1]
	inputCpf := os.Args[2]
	cpfUsuario := cpf.NewCpf(cpf.Cpf{Cpf: inputCpf})
	if option == "cdcpf" {
		fmt.Println(cpfUsuario.CalcularDigitosCpf())
	} else if option == "vcpf" {
		fmt.Println(cpfUsuario.VerificarCpf())
	} else {
		return
	}
}
