package cpf

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_VerificarCpf_1(t *testing.T) {
	assert.Equal(t, true, NewCpf(Cpf{"111.444.777-35"}).VerificarCpf())
}

func Test_VerificarCpf_2(t *testing.T) {
	assert.Equal(t, false, NewCpf(Cpf{"111.444.777-34"}).VerificarCpf())
}
