from cpf import Cpf

def calcular_digitos(cpf):
    cpf = Cpf.reter_numeros(cpf, literal=True)

    if not cpf.isdigit():
        print("O CPF é um número.")
        return

    if len(str(cpf)) < 9:
        cpf = str(cpf).rjust(9,'0')

    cpf_informado = "{}.{}.{}".format(
        cpf[0:3], cpf[3:6], cpf[6:9]
    )
    digitos = Cpf.obter_dvs(cpf)
    cpf_calculado = f"{cpf[:9]}{digitos[0]}{digitos[1]}"

    resultado1 = f"CPF informado: {cpf_informado}"
    resultado2 = f"CPF completo:  {Cpf.marcar(cpf_calculado)}"
    resultado3 = f"CPF completo:  {cpf_calculado}"

    print(resultado1)
    print(resultado2)
    print(resultado3)

    return (digitos[0], digitos[1])

if __name__ == "__main__":
    import sys
    cpf = str(sys.argv[1])
    print(calcular_digitos(cpf))
