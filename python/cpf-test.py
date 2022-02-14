import pytest
import cpf

class TestCpf:
    @pytest.fixture
    def C(self):
        return cpf.Cpf

    @pytest.mark.parametrize("cpf, resultado", [
        ("11144477799", "111.444.777-99"),
        ("11144477735", "111.444.777-35"),
        ("111444777999", False)
    ])
    def test_cpf_marcar(self, cpf, resultado, C):
        assert C.marcar(cpf) == resultado
    
    @pytest.mark.parametrize("digitos_cpf, resultado", [
        ([1, 1, 1, 4, 4, 4, 7, 7, 7], 3),
        ([1, 1, 1, 4, 4, 4, 7, 7, 7, 3], 5)
    ])
    def test_cpf_calcular_dv(self, digitos_cpf, resultado, C):
        assert C.calcular_dv(digitos_cpf) == resultado
    
    @pytest.mark.parametrize("cpf, resultado", [
        (11144477735, (3, 5)),
        (11144477799, (3, 5)),
    ])
    def test_cpf_obter_dvs(self, cpf, resultado, C):
        assert C.obter_dvs(cpf) == resultado
    
    @pytest.mark.parametrize("cpf, resultado", [
        (11144477735, True),
        (11144477799, False)
    ])
    def test_cpf_verificar(self, cpf, resultado, C):
        assert C.verificar(cpf) == resultado