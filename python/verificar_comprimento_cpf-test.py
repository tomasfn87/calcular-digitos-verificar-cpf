import pytest
import verificar_comprimento_cpf

class TestVerificarComprimentoCpf:
    @pytest.fixture
    def verificar_comprimento(self):
        return verificar_comprimento_cpf.verificar_comprimento
    
    @pytest.mark.parametrize("numero_cpf, resultado", [
        (111444777, 0),
        (11144477, 1)
    ])
    def test_verificar_comprimento(self, numero_cpf, resultado, verificar_comprimento):
        assert verificar_comprimento(numero_cpf) == resultado