class Cpf:
    def formatar(cpf):
        n_cpf = str(Cpf.reter_numeros(cpf, True))
        if len(n_cpf) != 11:
            return False
        n_cpf = Cpf.adicionar_separador(n_cpf, 2)
        n_cpf = Cpf.adicionar_separador(n_cpf, 6, ".")
        return Cpf.adicionar_separador(n_cpf, 10, ".")

    def calcular_dv(digitos_cpf):
        multiplicador = len(digitos_cpf) + 1
        calculo_dv = []
        for i in digitos_cpf:
            i *= multiplicador
            calculo_dv.append(i)
            multiplicador -= 1
        soma = 0
        for j in calculo_dv:
            soma += j
        resto = soma % 11
        if resto > 1:
            return 11 - resto
        return 0

    def obter_dvs(cpf):
        cpf = Cpf.reter_numeros(cpf, True)
        digitos_cpf = Cpf.obter_lista_digitos(cpf, 9)
        primeiro_dv_cpf = Cpf.calcular_dv(digitos_cpf)
        digitos_cpf.append(primeiro_dv_cpf)
        return primeiro_dv_cpf, Cpf.calcular_dv(digitos_cpf)

    def verificar(cpf):
        cpf = str(cpf)
        if not cpf.isdigit():
            return 'NaN'
        if len(cpf) < 11:
            cpf = cpf.rjust(11,'0')
        dvs = Cpf.obter_dvs(cpf)
        if int(cpf[-1]) == dvs[-1] and int(cpf[-2]) == dvs[-2]:
            return True
        return False

    def obter_lista_digitos(numero, limite=False):
        numero = str(numero)
        if limite == False:
            limite = len(numero)
        lista_digitos = []
        for i in range(0, limite):
            lista_digitos.append(int(numero[i]))
        return lista_digitos

    def reter_numeros(numero, literal=False, accept_float=False):
        real = False
        tipo = type(numero)
        assert tipo in [int, float, str]
        if tipo in [int, float]:
            return numero
        texto_numerico = ""
        for d in numero:
            if texto_numerico == "" and d == "-":
                texto_numerico += d
            if 47 < ord(d) < 58:
                texto_numerico += d
            elif d in [".", ","] and not real and accept_float:
                texto_numerico += "."
                real = True
        if texto_numerico in ["", "-", "."]:
            return numero
        if literal:
            return texto_numerico
        if real:
            return float(texto_numerico)
        return int(texto_numerico)

    def adicionar_separador(numero, posicao_do_final=4, separador="-"):
        numero = str(numero)
        if len(numero) <= posicao_do_final:
            return numero + separador
        else:
            texto_separado = ""
            for i in range(0, len(numero)):
                texto_separado += numero[i]
                if i == len(numero) - (posicao_do_final + 1):
                    texto_separado += separador
        return texto_separado
