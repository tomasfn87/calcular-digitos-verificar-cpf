package cpf

import (
	"fmt"
	"log"
	"strconv"
)

func CalcularDigitosCpf(cpf string) [2]int {
	cpf = ReterNumeros(cpf, 9)
	if len(cpf) < 9 {
		log.Fatal("o CPF informado deve ter no mínimo 9 dígitos")
	}
	digitosBaseCpf := obterDigitosCpf(cpf)
	var digitosCpf [10]int
	copy(digitosCpf[:], digitosBaseCpf[:])
	var DVsCpf [2]int
	DVsCpf[0] = calcularPrimeiroDV(digitosBaseCpf)
	digitosCpf[9] = DVsCpf[0]
	DVsCpf[1] = calcularSegundoDV(digitosCpf)
	cpfInformado := fmt.Sprintf("%s.%s.%s", cpf[0:3], cpf[3:6], cpf[6:9])
	cpfCompleto := fmt.Sprintf("%s-%d%d", cpfInformado, DVsCpf[0], DVsCpf[1])
	fmt.Printf("CPF informado: %s\n", cpfInformado)
	fmt.Printf("CPF completo : %s\n", cpfCompleto)
	return DVsCpf
}

func calcularDVCpf(digitosCpf []int) int {
	multiplicador := len(digitosCpf) + 1
	for i := 0; i < len(digitosCpf); i++ {
		digitosCpf[i] *= multiplicador
		multiplicador -= 1
	}
	soma := 0
	for j := 0; j < len(digitosCpf); j++ {
		soma += digitosCpf[j]
		soma %= 11
	}
	if soma < 2 {
		return 0
	}
	return 11 - soma
}

func calcularPrimeiroDV(digitosCpf [9]int) int {
	return calcularDVCpf(digitosCpf[:])
}

func calcularSegundoDV(digitosCpf [10]int) int {
	return calcularDVCpf(digitosCpf[:])
}

func obterDigitosCpf(cpf string) [9]int {
	var digitosCpf [9]int
	for i := range cpf {
		digito, _ := strconv.Atoi(cpf[i : i+1])
		digitosCpf[i] = digito
	}
	return digitosCpf
}

func ReterNumeros(cpf string, limite int) string {
	if limite == 0 {
		limite = len(cpf)
	}
	stringNumerica := ""
	n_digitos := 0
	for j, charCode := range cpf {
		if n_digitos == limite {
			break
		}
		if charCode >= 48 && charCode <= 57 {
			stringNumerica += cpf[j : j+1]
			n_digitos++
		}
	}
	return stringNumerica
}
