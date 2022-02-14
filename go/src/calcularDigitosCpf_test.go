package cpf

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_ReterNumeros_1(t *testing.T) {
	assert.Equal(t, "111444777", ReterNumeros("111.444.777", 9))
}

func Test_ReterNumeros_2(t *testing.T) {
	assert.Equal(t, "111444777", ReterNumeros("111.444.777-35", 9))
}

func Test_ReterNumeros_3(t *testing.T) {
	assert.Equal(t, "11144477735", ReterNumeros("111.444.777-35", 11))
}

func Test_ReterNumeros_4(t *testing.T) {
	assert.Equal(t, "11144477735", ReterNumeros("111.444.777-354", 11))
}

func Test_CalcularDigitosCpf_1(t *testing.T) {
	assert.Equal(t, [2]int{3, 5}, CalcularDigitosCpf("111.444.777-34"))
}

func Test_CalcularDigitosCpf_2(t *testing.T) {
	assert.Equal(t, [2]int{3, 5}, CalcularDigitosCpf("111.444.777-35"))
}
