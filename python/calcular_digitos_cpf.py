from cpf import Cpf

def calcular_digitos(cpf):
    cpf = Cpf.reter_numeros(cpf, True)

    assert len(str(cpf)) >= 9

    cpf_informado = "{}.{}.{}".format(
        cpf[0:3], cpf[3:6], cpf[6:9]
    )

    digitos = Cpf.obter_dvs(cpf)

    resultado1 = "CPF informado: {}".format(cpf_informado)

    resultado2 = "CPF completo:  {}".format(
        Cpf.marcar(str(cpf[:9]) + str(digitos[0]) + str(digitos[1]))
    )

    resultado3 = "CPF completo:  {}{}{}".format(
        cpf[:9], str(digitos[0]), str(digitos[1])
    )

    print(resultado1)
    print(resultado2)
    print(resultado3)

    return (digitos[0], digitos[1])

if __name__ == "__main__":
    import sys
    cpf = str(sys.argv[1])
    print(calcular_digitos(cpf))
