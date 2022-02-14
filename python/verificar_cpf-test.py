import pytest
import verificar_cpf

class TestVerificarCpf:
    @pytest.fixture
    def verificar(self):
        return verificar_cpf.verificar

    @pytest.mark.parametrize("numero_cpf, resultado", [
        (11144477735, 0),
        (11144477799, 1)
    ])
    def test_verificar_cpf(self, numero_cpf, resultado, verificar):
        assert verificar(numero_cpf) == resultado
