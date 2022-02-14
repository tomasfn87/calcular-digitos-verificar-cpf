def verificar_comprimento(cpf):
    if type(cpf) != str:
        cpf = str(cpf)
    if len(cpf) < 9:
        return 1
    return 0

if __name__ == "__main__":
    import sys
    cpf = str(sys.argv[1])
    print(verificar_comprimento(cpf))
