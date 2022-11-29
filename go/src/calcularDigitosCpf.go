package cpf

import (
	"fmt"
	"log"
	"strconv"
)

type CalcularDigitosVerificarCpf interface {
	CalcularDigitosCpf()
	VerificarCpf()
}

type Cpf struct {
	Cpf string
}

func NewCpf(c Cpf) *Cpf {
	return &Cpf{c.Cpf}
}

type Digitos struct {
	cpf    Cpf
	limite int
}

func NewDigitos(d Digitos) *Digitos {
	return &Digitos{d.cpf, d.limite}
}

func (c *Cpf) ObterDigitosCpf() [9]int {
	var digitosCpf [9]int
	for i := range c.Cpf {
		digito, _ := strconv.Atoi(c.Cpf[i : i+1])
		digitosCpf[i] = digito
	}
	return digitosCpf
}

func (c *Cpf) CalcularDigitosCpf(loud bool) [2]int {
	c.Cpf = NewDigitos(Digitos{*c, 9}).ReterNumeros()
	if len(c.Cpf) < 9 {
		log.Fatal("o CPF informado deve ter no mínimo 9 dígitos")
	}
	digitosBaseCpf := c.ObterDigitosCpf()
	var digitosCpf [10]int
	copy(digitosCpf[:], digitosBaseCpf[:])
	var DVsCpf [2]int
	DVsCpf[0] = calcularPrimeiroDV(digitosBaseCpf)
	digitosCpf[9] = DVsCpf[0]
	DVsCpf[1] = calcularSegundoDV(digitosCpf)
	cpfInformado :=
		fmt.Sprintf("%s.%s.%s", c.Cpf[0:3], c.Cpf[3:6], c.Cpf[6:9])
	cpfCompleto := fmt.Sprintf("%s-%d%d", cpfInformado, DVsCpf[0], DVsCpf[1])
	if loud {
		fmt.Printf("CPF informado: %s\n", cpfInformado)
		fmt.Printf("CPF completo:  %s\n", cpfCompleto)
	}
	return DVsCpf
}

func (d *Digitos) ReterNumeros() string {
	if d.limite <= 0 {
		d.limite = len(d.cpf.Cpf)
	}
	stringNumerica := ""
	n_digitos := 0
	for j, charCode := range d.cpf.Cpf {
		if n_digitos == d.limite {
			break
		}
		if charCode >= 48 && charCode <= 57 {
			stringNumerica += d.cpf.Cpf[j : j+1]
			n_digitos++
		}
	}
	return stringNumerica
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
