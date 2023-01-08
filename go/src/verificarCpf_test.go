package cpf

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_VerificarCpf_1(t *testing.T) {
	assert.Equal(t, true, NewCpf(Cpf{"111.444.777-35"}).VerificarCpf(false))
}

func Test_VerificarCpf_2(t *testing.T) {
	assert.Equal(t, false, NewCpf(Cpf{"111.444.777-34"}).VerificarCpf(false))
}

func Test_VerificarCpf_3(t *testing.T) {
	assert.Equal(t, false, NewCpf(Cpf{"192"}).VerificarCpf(false))
}

func Test_VerificarCpf_4(t *testing.T) {
	assert.Equal(t, true, NewCpf(Cpf{"191"}).VerificarCpf(false))
}

func Test_VerificarCpf_5(t *testing.T) {
	assert.Equal(t, true, NewCpf(Cpf{"0"}).VerificarCpf(false))
}

func Test_VerificarCpf_6(t *testing.T) {
	assert.Equal(t, false, NewCpf(Cpf{"1"}).VerificarCpf(false))
}
