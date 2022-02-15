package cpf

import (
	"fmt"
	"log"
	"strconv"
)

func CalcularDigitosCpf(cpf string) [2]int {
	cpf = ReterNumeros(cpf, 9)
	digitosBase := obterDigitosCpf(cpf)
	var digitosVerificadoresCpf [2]int
	var digitosCpf [10]int
	copy(digitosCpf[:], digitosBase[:])
	digitosVerificadoresCpf[0] = calcularPrimeiroDigitoCpf(digitosBase)
	digitosCpf[9] = digitosVerificadoresCpf[0]
	digitosVerificadoresCpf[1] = calcularSegundoDigitoCpf(digitosCpf)
	cpfInformado := fmt.Sprintf("%s.%s.%s", cpf[0:3], cpf[3:6], cpf[6:9])
	cpfCompleto := fmt.Sprintf("%s-%d%d", cpfInformado,
		digitosVerificadoresCpf[0], digitosVerificadoresCpf[1])
	fmt.Printf("CPF informado: %s\n", cpfInformado)
	fmt.Printf("CPF completo : %s\n", cpfCompleto)
	return digitosVerificadoresCpf
}

func calcularDigitoCpf(digitosCpf []int) int {
	multiplicador := len(digitosCpf) + 1
	for i := 0; i < len(digitosCpf); i++ {
		digitosCpf[i] *= multiplicador
		multiplicador -= 1
	}
	somaAposMultiplicacao := 0
	for j := 0; j < len(digitosCpf); j++ {
		somaAposMultiplicacao += digitosCpf[j]
		somaAposMultiplicacao %= 11
	}
	if somaAposMultiplicacao < 2 {
		return 0
	}
	return 11 - somaAposMultiplicacao
}

func calcularPrimeiroDigitoCpf(digitosCpf [9]int) int {
	return calcularDigitoCpf(digitosCpf[:])
}

func calcularSegundoDigitoCpf(digitosCpf [10]int) int {
	return calcularDigitoCpf(digitosCpf[:])
}

func obterDigitosCpf(cpf string) [9]int {
	if len(cpf) < 9 {
		log.Fatal("o CPF informado deve ter no mínimo 9 dígitos")
	}
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
