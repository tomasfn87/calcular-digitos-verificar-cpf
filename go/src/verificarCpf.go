package cpf

import (
	"fmt"
	"strconv"
)

func (c *Cpf) VerificarCpf(loud bool) bool {
	c.Cpf = NewDigitos(Digitos{*c, 11}).ReterNumeros()
	if len(c.Cpf) < 11 {
		c.Cpf = PadRight(c.Cpf, "0", 11-len(c.Cpf))
	}
	var digitosRecebidos [2]int
	primeiroDigito, _ := strconv.Atoi(c.Cpf[9:10])
	segundoDigito, _ := strconv.Atoi(c.Cpf[10:11])
	digitosRecebidos[0] = primeiroDigito
	digitosRecebidos[1] = segundoDigito
	digitosCalculados := c.CalcularDigitosCpf(loud)
	cpfCompleto := fmt.Sprintf(
		"%s.%s.%s-%d%d", c.Cpf[0:3], c.Cpf[3:6], c.Cpf[6:9],
		digitosCalculados[0], digitosCalculados[1])
	resultado, validez := "inválido", false
	if digitosRecebidos == digitosCalculados {
		resultado, validez = resultado[2:], !validez
	}
	if loud {
		fmt.Printf("O CPF %s-%d%d é %s.\n", cpfCompleto[:11],
			digitosRecebidos[0], digitosRecebidos[1], resultado)
	}
	return validez
}
