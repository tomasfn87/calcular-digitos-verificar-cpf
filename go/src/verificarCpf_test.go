package cpf

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_VerificarCpf_1(t *testing.T) {
	assert.Equal(t, true, VerificarCpf("111.444.777-35"))
}

func Test_VerificarCpf_2(t *testing.T) {
	assert.Equal(t, false, VerificarCpf("111.444.777-34"))
}
