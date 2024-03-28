func main
    index_diff = 0
    if sysargv[1] = "ring"
        index_diff++ ok

    if len(sysargv) < (2 + index_diff)
        help_user()
        return ok

    option = sysargv[(2 + index_diff)]
    if option = "--demo"
        demo()
        return ok

    if len(sysargv) < (3 + index_diff)
        help_user() ok

    cpf = sysargv[(3 + index_diff)]
    if !len(reter_numeros(cpf, 1))
        help_user()
        return ok

    if option = "-v" or option = "--verificar" 
        valid = verificar(cpf)
        see "O CPF " + formatar(cpf) + " é "
        if !valid
            see "in" ok
        see "válido." + nl 
    but option = "-c" or option "--calcular"
        dvs = calcular_digitos(cpf)
        see listar_dvs(dvs) + nl ok

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

    see "FORMATAR CPF" + nl
    see "- formatar('12360')                  = '"
    see formatar("12360") + "'" + nl
    see "- formatar('12345678909')            = '"
    see formatar("12345678909") + "'" + nl + nl

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

func help_user
    see "Digite uma das opções abaixo:" + nl
    see "- '-v' ou '--verificar' e um número de CPF;" + nl
    see "- '-c' ou '--calcular' e um número de CPF;" + nl
    see "- '--demo'." + nl

func formatar cpf
    only_nums = reter_numeros(cpf, 11)
    if !len(only_nums)
        return "" ok
    cpf1 = substr(only_nums, 1, 3)
    cpf2 = substr(only_nums, 4, 3)
    cpf3 = substr(only_nums, 7, 3)
    cpf4 = substr(only_nums, 10, 2)
    return cpf1+"."+cpf2+"."+cpf3+"-"+cpf4

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
