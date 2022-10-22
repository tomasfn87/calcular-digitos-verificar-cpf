from cpf import Cpf

def verificar(cpf):
    cpf = Cpf.reter_numeros(cpf, literal=True)
    v = Cpf.verificar(cpf)
    if v == 'NaN': return 2
    if v: return 0
    return 1

if __name__ == "__main__":
    import sys
    cpf = str(sys.argv[1])
    print(verificar(cpf))