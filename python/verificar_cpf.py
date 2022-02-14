from cpf import Cpf

def verificar(cpf):
    if type(cpf) != str:
        cpf = str(cpf)
    if Cpf.verificar(cpf):
        return 0 # 0 significa sem erro, como em exit 0, em bash
    else:
        return 1 # 1 significa erro #1, como em exit 1, em bash

if __name__ == "__main__":
    import sys
    cpf = str(sys.argv[1])
    print(verificar(cpf))
