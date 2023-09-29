from cpf import Cpf

def calcular_digitos(cpf):
    cpf = Cpf.reter_numeros(cpf, literal=True)
    if not cpf.isdigit():
        return 1
    if len(cpf) < 9:
        cpf = cpf.rjust(9, '0')
    cpf_informado = f"{cpf[0:3]}.{cpf[3:6]}.{cpf[6:9]}"
    digitos = Cpf.obter_dvs(cpf)
    cpf_calculado = f"{cpf[:9]}{digitos[0]}{digitos[1]}"
    print(f"CPF informado: {cpf_informado}")
    print(f"CPF completo:  {Cpf.formatar(cpf_calculado)}")
    print(f"               {cpf_calculado}")
    return (digitos[0], digitos[1])

if __name__ == "__main__":
    import sys
    cpf = sys.argv[1]
    print(calcular_digitos(cpf))
