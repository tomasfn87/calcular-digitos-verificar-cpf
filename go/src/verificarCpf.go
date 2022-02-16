package cpf

import (
	"fmt"
	"log"
	"strconv"
)

func VerificarCpf(cpf string) bool {
	cpf = NewDigitos(cpf, 11).ReterNumeros()
	if len(cpf) < 11 {
		log.Fatal("o CPF informado deve ter 11 dígitos")
	}
	var digitosRecebidos [2]int
	primeiroDigito, _ := strconv.Atoi(cpf[9:10])
	segundoDigito, _ := strconv.Atoi(cpf[10:11])
	digitosRecebidos[0] = primeiroDigito
	digitosRecebidos[1] = segundoDigito
	digitosCalculados := CalcularDigitosCpf(cpf)
	cpfCompleto := fmt.Sprintf("%s.%s.%s-%d%d", cpf[0:3], cpf[3:6], cpf[6:9],
		digitosCalculados[0], digitosCalculados[1])
	resultado, validez := "inválido", false
	if digitosRecebidos == digitosCalculados {
		resultado, validez = resultado[2:], !validez
	}
	fmt.Printf("O CPF %s-%d%d é %s.\n", cpfCompleto[:11],
		digitosRecebidos[0], digitosRecebidos[1], resultado)
	return validez
}
