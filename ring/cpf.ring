func main
    demo()

func demo
    see "reter_numeros(texto, n)" + nl
    see '- reter_numeros("test"   , 1) = "'
    see reter_numeros("test", 1) + '"' + nl
    see '- reter_numeros("test123", 2) = "'
    see reter_numeros("test123", 2) + '"' + nl
    see '- reter_numeros("test123", 3) = "'
    see reter_numeros("test123", 3) + '"' + nl
    see '- reter_numeros("test123", 4) = "'
    see reter_numeros("test123", 4) + '"' + nl + nl

    see "calcular_digito_verificador(only_nums)" + nl
    see '- calcular_digito_verificador("0")   = '
    see calcular_digito_verificador("0") + nl
    see '- calcular_digito_verificador("123") = '
    see calcular_digito_verificador("123") + nl

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
