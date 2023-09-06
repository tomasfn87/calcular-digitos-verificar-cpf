function verificar(CPF)
    cpf = reterNumeros(CPF, 11)
    if length(cpf) < 1
        return false end
    digitosRecebidos = [
        parse(Int64, cpf[end-1]),
        parse(Int64, cpf[end]) ]
    digitosCalculados = calcularDigitos(cpf[1:9])
    if digitosRecebidos[1] == digitosCalculados[1] && digitosRecebidos[2] == digitosCalculados[2]
        return true end
    return false end

function calcularDigitos(CPF)
    cpf = reterNumeros(CPF, 9)
    if length(cpf) < 1
        return false end
    digitosVerificadores = [ 0, 0 ]
    multiplicador = 10
    soma = 0
    for char in cpf
        soma += multiplicador * parse(Int64, char)
        multiplicador -= 1 end
    resto = soma % 11
    if resto > 1
        digitosVerificadores[1] = 11 - resto end
    soma = 0
    multiplicador = 11
    for char in cpf
        soma += multiplicador * parse(Int64, char)
        multiplicador -= 1 end
    soma += digitosVerificadores[1] * multiplicador
    resto = soma % 11
    if resto > 1
        digitosVerificadores[2] = 11 - resto end
    return digitosVerificadores end

function reterNumeros(texto, n)
    if length(texto) < 1
        return "" end
    apenasNums, cont = "", 0
    for char in texto
        if Int(char) > 47 && Int(char) < 58
            apenasNums = apenasNums * string(char)
            cont += 1 end
        if cont == n
            break end end
    if cont == 0
        return "" end
    while length(apenasNums) < n
        apenasNums = "0" * apenasNums end
    return apenasNums end

if ARGS[1] == "--demo"
    println(" 1) reterNumeros(texto, n):\n 1.1) recebe um texto e um número inteiro, n;\n 1.2) retorna os n primeiros números disponíveis do texto recebido ou um texto vazio, preenchendo o número com zeros à esquerda caso o texto recebido possuir menos de n algarismos.")
    println()
    println("  - reterNumeros(\"test123\", 3) --> \"", reterNumeros("test123", 3), "\""); # Expected result: "123"
    println("  - reterNumeros(\"test123\", 2) --> \"", reterNumeros("test123", 2), "\""); # Expected result: "12"
    println("  -   reterNumeros(\"test1\", 2) --> \"", reterNumeros("test1", 2), "\""); # Expected result: "1"
    println("  -    reterNumeros(\"test\", 1) --> \"", reterNumeros("test", 1), "\""); # Expected result: ""
    println("  -        reterNumeros(\"\", 2) --> \"", reterNumeros("", 2), "\""); # Expected result: ""
    println()
    println()
    println(" 2) calcularDigitos(cpf):\n 2.1) recebe um texto que será verificado por conteúdo numérico;\n 2.2) retorna false caso o texto recebido não possua conteúdo numérico.\n 2.3) retorna 2 inteiros caso um texto com conteúdo numérico seja recebido (apenas os 9 primeiros dígitos serão utilizados para cálculo dos dígitos verificadores).")
    println()
    println("  -       calcularDigitos(\"a\") --> ", calcularDigitos("a"))
    println("  -       calcularDigitos(\"0\") --> ", calcularDigitos("0"))
    println("  -     calcularDigitos(\"123\") --> ", calcularDigitos("123"))
    println()
    println()
    println(" 3) verificar(cpf):\n 3.1) recebe um texto que será verificado por conteúdo numérico;\n 3.1.1) retorna false caso o texto recebido não possua conteúdo numérico.\n 3.1.2) no caso de conteúdo numérico detectado, o número é tido como um número de CPF completo:\n 3.1.2.1) caso possua menos do que 11 caracteres numéricos, o CPF será completado com zeros à esquerda;\n 3.1.2.2) os dois últimos dígitos são considerados dígitos verificadores, e sobre os nove dígitos restantes é feito o cálculo de dígitos verificadores:\n 3.1.2.2.1) se os 2 últimos dígitos recebidos forem iguais aos dígitos calculados, retorna true;\n 3.1.2.2.2) caso contrário, retorna false.")
    println()
    println("  -             verificar(\"a\") --> ", verificar("a"))
    println("  -             verificar(\"0\") --> ", verificar("0"))
    println("  -         verificar(\"12360\") --> ", verificar("12360"))
elseif ARGS[1] == "--verificar" || ARGS[1] == "-v"
    println(verificar(ARGS[2]))
elseif ARGS[1] == "--calcular" || ARGS[1] == "-c"
    println(calcularDigitos(ARGS[2]))
else
    println("Digite:")
    println(" 1) '--demo' para visualizar uma demonstração do programa;")
    println(" 2) '--calcular' ou '-c' e número de CPF para efetuar o cálculo dos dígitos verificadores;")
    println(" 3) '--verificar' ou '-v' e número de CPF para efetuar a verificação do CPF.") end