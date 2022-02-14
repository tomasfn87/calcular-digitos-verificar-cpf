import pytest
import calcular_digitos_cpf

# calcular_digitos_cpf.calcular_digitos("111444777")

class TestCalcularDigitosCpf:
    @pytest.fixture
    def calcular_digitos(self):
        return calcular_digitos_cpf.calcular_digitos

    @pytest.mark.parametrize("numero_cpf, resultado", [
        ("111444777", (3, 5)),
        ("11144477799", (3, 5)),
        ("11144477735", (3, 5))
    ])
    def test_calcular_digitos(self, numero_cpf, resultado, calcular_digitos):
        assert calcular_digitos(numero_cpf) == resultado
