package cpf

import (
	"log"
	"strconv"
)

func CalcularDigitosCpf(cpf string) [2]int {
	var digitosVerificadoresCpf [2]int
	digitosBase := obterDigitosCpf(cpf)
	var digitosCpf [10]int
	for i, _ := range digitosBase {
		digitosCpf[i] = digitosBase[i]
	}
	digitosVerificadoresCpf[0] =
		calcularPrimeiroDigitoCpf(obterDigitosCpf(cpf))
	digitosCpf[9] = calcularPrimeiroDigitoCpf(obterDigitosCpf(cpf))
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
	cpf = reterNumeros(cpf, 9)
	var digitosCpf [9]int
	for i, _ := range cpf {
		digito, err := strconv.Atoi(cpf[i : i+1])
		if err != nil {
			log.Fatal(err)
		}
		digitosCpf[i] = digito
	}
	return digitosCpf
}

func reterNumeros(cpf string, limite int) string {
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

// func main() {
// fmt.Println(reterNumeros("111.444.777-35", 9))
// fmt.Println(obterDigitosCpf("111.444.777-35"))
// fmt.Println(calcularDigitoCpf(obterDigitosCpf("111.444.777-35")))
// fmt.Println(CalcularDigitosCpf("111.444.777-35"))
// }
