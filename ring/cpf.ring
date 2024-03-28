func main
    demo()

func demo
    see "reter_numeros(texto, n)" + nl
    see '- reter_numeros("test"   , 1) = "' + reter_numeros("test", 1) + '"' + nl
    see '- reter_numeros("test123", 2) = "' + reter_numeros("test123", 2) + '"' + nl
    see '- reter_numeros("test123", 3) = "' + reter_numeros("test123", 3) + '"' + nl
    see '- reter_numeros("test123", 4) = "' + reter_numeros("test123", 4) + '"' + nl

func reter_numeros texto, n
    only_nums = ""
    count = 0
    for i = 1 to len(texto)
        if strcmp(texto[i], "0") >= 0 and strcmp(texto[i], "9") <= 0
            only_nums = only_nums + texto[i]
            count++ ok
        if count = n
            exit ok next
    if count != 0 and len(only_nums) < n
        only_nums = copy("0", (n - count)) + only_nums ok
    return only_nums
