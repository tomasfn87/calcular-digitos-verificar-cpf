package cpf

import (
	"log"
	"strconv"
)

func CalcularDigitosCpf(cpf string) [2]int {
	digitosBase := obterDigitosCpf(cpf)
	var digitosVerificadoresCpf [2]int
	var digitosCpf [10]int
	for i := range digitosBase {
		digitosCpf[i] = digitosBase[i]
	}
	digitosVerificadoresCpf[0] =
		calcularPrimeiroDigitoCpf(digitosBase)
	digitosCpf[9] = calcularPrimeiroDigitoCpf(digitosBase)
	digitosVerificadoresCpf[1] = calcularSegundoDigitoCpf(digitosCpf)
	return digitosVerificadoresCpf
}

func calcularPrimeiroDigitoCpf(digitosCpf [9]int) int {
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

func calcularSegundoDigitoCpf(digitosCpf [10]int) int {
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

func obterDigitosCpf(cpf string) [9]int {
	cpf = ReterNumeros(cpf, 9)
	if len(cpf) < 9 {
		log.Fatal("o CPF informado deve ter no mínimo 9 dígitos")
	}
	var digitosCpf [9]int
	for i := range cpf {
		digito, err := strconv.Atoi(cpf[i : i+1])
		if err != nil {
			log.Fatal(err)
		}
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
