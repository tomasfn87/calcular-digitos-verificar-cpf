package cpf

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_ReterNumeros_1(t *testing.T) {
	assert.Equal(t, "111444777", NewDigitos(Digitos{Cpf{"111.444.777"}, 9}).ReterNumeros())
}

func Test_ReterNumeros_2(t *testing.T) {
	assert.Equal(t, "111444777", NewDigitos(Digitos{Cpf{"111.444.777-35"}, 9}).ReterNumeros())
}

func Test_ReterNumeros_3(t *testing.T) {
	assert.Equal(t, "11144477735", NewDigitos(Digitos{Cpf{"111.444.777-35"}, 11}).ReterNumeros())
}

func Test_ReterNumeros_4(t *testing.T) {
	assert.Equal(t, "11144477735", NewDigitos(Digitos{Cpf{"111.444.777-354"}, 11}).ReterNumeros())
}

func Test_ReterNumeros_5(t *testing.T) {
	assert.Equal(t, "21", NewDigitos(Digitos{Cpf{"a21"}, 11}).ReterNumeros())
}

func Test_CalcularDigitosCpf_1(t *testing.T) {
	assert.Equal(t, [2]int{3, 5}, NewCpf(Cpf{"111.444.777-34"}).CalcularDigitosCpf(false))
}

func Test_CalcularDigitosCpf_2(t *testing.T) {
	assert.Equal(t, [2]int{3, 5}, NewCpf(Cpf{"111.444.777-35"}).CalcularDigitosCpf(false))
}

func Test_CalcularDigitosCpf_3(t *testing.T) {
	assert.Equal(t, [2]int{9, 1}, NewCpf(Cpf{"1"}).CalcularDigitosCpf(false))
}

func Test_CalcularDigitosCpf_4(t *testing.T) {
	assert.Equal(t, [2]int{0, 0}, NewCpf(Cpf{"0"}).CalcularDigitosCpf(false))
}
