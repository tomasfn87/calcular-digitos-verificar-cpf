func main
    demo()

func listar_dvs dvs
    s = "[ "
    s += dvs[1]
    s += ", "
    s += dvs[2]
    return s + " ]"

func demo
    see "RETER_NUMEROS TEXTO, N" + nl
    see "- reter_numeros('test'   , 1)        = '"
    see reter_numeros("test", 1) + "'" + nl
    see "- reter_numeros('test123', 2)        = '"
    see reter_numeros("test123", 2) + "'" + nl
    see "- reter_numeros('test123', 3)        = '"
    see reter_numeros("test123", 3) + "'" + nl
    see "- reter_numeros('test123', 4)        = '"
    see reter_numeros("test123", 4) + "'" + nl + nl

    see "CALCULAR_DIGITO_VERIFICADOR ONLY_NUMS" + nl
    see "- calcular_digito_verificador('0'  ) = "
    see calcular_digito_verificador("0") + nl
    see "- calcular_digito_verificador('123') = "
    see calcular_digito_verificador("123") + nl + nl

    see "CALCULAR_DIGITOS CPF" + nl 
    see "- calcular_digitos('0')              = "
    see listar_dvs(calcular_digitos("0")) + nl
    see "- calcular_digitos('123')            = "
    see listar_dvs(calcular_digitos("123")) + nl + nl

    see "VERIFICAR CPF" + nl 
    see "- verificar('0')                     = "
    see verificar("0") + nl
    see "- verificar('12360')                 = "
    see verificar("12360") + nl
    see "- verificar('111.444.777-35')        = "
    see verificar("111.444.777-35") + nl
    see "- verificar('111.444.777-34')        = "
    see verificar("111.444.777-34") + nl

func verificar cpf
    only_nums = reter_numeros(cpf, 11)
    if !len(only_nums)
        return False ok
    dvs_recebidos = [Number(only_nums[10]), Number(only_nums[11])]
    dvs_calculados = calcular_digitos(reter_numeros(only_nums, 9))
    for i = 1 to 2
        if dvs_recebidos[i] != dvs_calculados[i]
            return False ok next
    return True

func calcular_digitos cpf
    only_nums = reter_numeros(cpf, 9)
    if !len(only_nums)
        return False ok
    dvs = [ 0, 0 ]
    dvs[1] = calcular_digito_verificador(only_nums)
    only_nums += String(dvs[1])
    dvs[2] = calcular_digito_verificador(only_nums)
    return dvs

func calcular_digito_verificador only_nums
   sum = 0
   factor = len(only_nums) + 1
   for i = 1 to len(only_nums)
       sum += factor * Number(only_nums[i])
       factor-- next
   rem = sum % 11
   if rem > 1
       return 11 - rem ok
   return 0

func reter_numeros texto, n
    only_nums = ""
    count = 0
    for i = 1 to len(texto)
        if isDigit(texto[i])
            only_nums += texto[i]
            count++ ok
        if count = n
            exit ok next
    if count != 0 and len(only_nums) < n
        only_nums = copy("0", (n - count)) + only_nums ok
    return only_nums
