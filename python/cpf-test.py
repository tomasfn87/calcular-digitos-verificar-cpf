import pytest
import cpf

class TestCpf:
    @pytest.fixture
    def C(self):
        return cpf.Cpf

    @pytest.mark.parametrize("cpf, resultado", [
        ("11144477799", "111.444.777-99"),
        ("11144477735", "111.444.777-35"),
        ("111444777999", "111.444.777-99")
    ])
    def test_cpf_formatar(self, cpf, resultado, C):
        assert C.formatar(cpf) == resultado

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

    @pytest.mark.parametrize("numero, resultado", [
        (987654321,   "98765-4321"),
        (999123456,   "99912-3456"),
        (12345,       "1-2345"),
        ("987654321", "98765-4321"),
        ("999123456", "99912-3456"),
        ("12345",     "1-2345"),
        ("1234",      "1234-"),
        (1234,        "1234-"),
        (123,         "123-"),
        ("321",       "321-")
    ])
    def test_cpf_adicionar_separador_simples(self, numero, resultado, C):
        # Simples, pois não são passados nem o segundo nem o terceiro parâmetro
        assert C.adicionar_separador(numero) == resultado

    @pytest.mark.parametrize("numero, posicao, resultado", [
        (987654321,    4, "98765-4321"),
        ("987654321",  4, "98765-4321"),
        (12345,        4, "1-2345"),
        (12345,        3, "12-345"),
        (12345,        2, "123-45"),
        (12345,        5, "12345-"),
        (12345,        6, "12345-"),
        (14900800,     3, "14900-800"),
        (13200300,     3, "13200-300"),
        (12100200,     3, "12100-200"),
        ("0800123456", 6, "0800-123456"),
        ("0800122436", 6, "0800-122436"),
        ("0800112244", 6, "0800-112244")
    ])
    def test_cpf_adicionar_separador_intermediario(self, numero, posicao, resultado, C):
        # Intermediário, pois não é passado o terceiro parâmetro
        assert C.adicionar_separador(numero, posicao) == resultado

    @pytest.mark.parametrize("numero, posicao, separador, resultado", [
        ("0800123456", 6, " ", "0800 123456"),
        ("0800122436", 6, ".", "0800.122436"),
        ("0800112244", 6, "-", "0800-112244"),
        ("0800122436", 6, " ", "0800 122436"),
        ("0800122436", 6, ".", "0800.122436"),
        ("0800112244", 6, "-", "0800-112244"),
        ("tomas.nallealumni.usp.br", 13, "@@@", "tomas.nalle@@@alumni.usp.br"),
        ("tomas.nallealumni.usp.br", 13, "@",   "tomas.nalle@alumni.usp.br"),
        ("tomasfnalle@gmailcom",     3,  "...", "tomasfnalle@gmail...com"),
        ("tomasfnalle@gmailcom",     3,  ".",   "tomasfnalle@gmail.com")
    ])
    def test_cpf_adicionar_separador_completo(self, numero, posicao, separador, resultado, C):
        assert C.adicionar_separador(numero, posicao, separador) == resultado

    @pytest.mark.parametrize("numero, resultado", [
        ("123.456.789-01",                   12345678901),
        ("-123.456.789-01",                  -12345678901),
        ("+55(11)98765-4321)",               5511987654321),
        ("-+55(11)98765-4321)",              -5511987654321),
        ("!S01234567890E~^",                 1234567890),
        ("afduhas3fdiuha2sduf1hasdjfhasd",   321),
        ("papagaio",                         "papagaio"),
        ('{"nome": "arara", "tipo": "ave"}', '{"nome": "arara", "tipo": "ave"}'),
        ('{"nome": "arara", "peso_kg": 12}', 12),
        ("-ahsdfasofd-1",                    -1),
        (0,                                  0),
        (1,                                  1),
        ('01',                               1),
        ('0',                                0),
    ])
    def test_cpf_reter_numeros_simples(self, numero, resultado, C):
        assert C.reter_numeros(numero) == resultado

    @pytest.mark.parametrize("numero, literal, resultado", [
        ("1234", True,  "1234"),
        ("0123", True,  "0123"),
        ("0123", False, 123),
        ("0",    False, 0),
        ("0",    True,  "0")
    ])
    def test_cpf_reter_numeros_intermediario(self, numero, literal, resultado, C):
        assert C.reter_numeros(numero, literal) == resultado

    @pytest.mark.parametrize("numero, literal, accept_float, resultado", [
        ("12.34", True, True, "12.34"),
        (12.34, True, True, "12.34"),
        ("12.34", False, True, 12.34),
        (12.34, False, True, 12.34),
        ("01.23", True, False, "0123"),
        ("01.23", True, True, "01.23"),
        ("01.23", False, True, 1.23),
        ("-01.23", False, True, -1.23),
        ('{"nome": "arara", "peso_kg": 12}', False, True, 0.12)
    ])
    def test_cpf_reter_numeros_completo(self, numero, literal, accept_float, resultado, C):
        assert C.reter_numeros(numero, literal, accept_float) == resultado

    @pytest.mark.parametrize("numero, resultado", [
        ("111444777",   [1, 1, 1, 4, 4, 4, 7, 7, 7]),
        ("11144477735", [1, 1, 1, 4, 4, 4, 7, 7, 7, 3, 5]),
        ("11144477799", [1, 1, 1, 4, 4, 4, 7, 7, 7, 9, 9])
    ])
    def test_cpf_obter_lista_digitos_simples(self, numero, resultado, C):
        assert C.obter_lista_digitos(numero) == resultado

    @pytest.mark.parametrize("numero, limite, resultado", [
        ("111444777",   9,  [1, 1, 1, 4, 4, 4, 7, 7, 7]),
        ("11144477735", 9,  [1, 1, 1, 4, 4, 4, 7, 7, 7]),
        ("11144477799", 11, [1, 1, 1, 4, 4, 4, 7, 7, 7, 9, 9])
    ])
    def test_cpf_obter_lista_digitos_completo(self, numero, limite, resultado, C):
        assert C.obter_lista_digitos(numero, limite) == resultado

