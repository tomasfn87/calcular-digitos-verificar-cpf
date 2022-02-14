package cpf

import (
	"log"
	"strconv"
)

func VerificarCpf(cpf string) bool {
	cpf = ReterNumeros(cpf, 11)
	if len(cpf) < 11 {
		log.Fatal("o CPF informado deve ter 11 dígitos")
	}
	var digitosRecebidos [2]int
	primeiroDigito, _ := strconv.Atoi(cpf[9:10])
	segundoDigito, _ := strconv.Atoi(cpf[10:11])
	digitosRecebidos[0] = primeiroDigito
	digitosRecebidos[1] = segundoDigito
	digitosCalculados := CalcularDigitosCpf(cpf)
	return digitosRecebidos == digitosCalculados
}
