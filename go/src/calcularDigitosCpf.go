package cpf

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"
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
		c.Cpf = PadRight(c.Cpf, "0", 9)
	}
	digitosBaseCpf := c.ObterDigitosCpf()
	var digitosCpf [10]int
	copy(digitosCpf[:], digitosBaseCpf[:])
	var DVsCpf [2]int
	DVsCpf[0] = calcularPrimeiroDV(digitosBaseCpf)
	digitosCpf[9] = DVsCpf[0]
	DVsCpf[1] = calcularSegundoDV(digitosCpf)
	if loud {
		cpfInformado := fmt.Sprintf(
			"%s.%s.%s", c.Cpf[0:3], c.Cpf[3:6], c.Cpf[6:9])
		cpfCompleto := fmt.Sprintf(
			"%s-%d%d", cpfInformado, DVsCpf[0], DVsCpf[1])
		fmt.Printf("CPF informado: %s\n", cpfInformado)
		fmt.Printf("CPF completo:  %s\n", cpfCompleto)
		fmt.Printf("               %s%d%d\n", c.Cpf[:], DVsCpf[0], DVsCpf[1])
	}
	return DVsCpf
}

func (d *Digitos) ReterNumeros() string {
	RENotNumbers := regexp.MustCompile(`\D`)
	cpf := RENotNumbers.ReplaceAllString(d.cpf.Cpf, "")
	if len(cpf) > d.limite {
		return cpf[0:d.limite]
	}
	return cpf
}

func PadRight(text string, char string, size int) string {
	return fmt.Sprintf("%s%s", repeatChar(char, size-len(text)), text)
}

func repeatChar(char string, size int) string {
	return strings.Repeat(fmt.Sprintf("%c", char[0]), size)
}

func calcularDVCpf(digitosCpf []int) int {
	multiplicador := len(digitosCpf) + 1
	soma := 0
	for _, v := range digitosCpf {
		soma += v * multiplicador
		multiplicador -= 1
	}
	resto := soma % 11
	if resto < 2 {
		return 0
	}
	return 11 - resto
}

func calcularPrimeiroDV(digitosCpf [9]int) int {
	return calcularDVCpf(digitosCpf[:])
}

func calcularSegundoDV(digitosCpf [10]int) int {
	return calcularDVCpf(digitosCpf[:])
}
