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
    return apenasNums; end

function calcularDigitos(CPF)
    cpf = reterNumeros(CPF, 9)
    if length(cpf) < 1
        return false end
    digitosVerificadores = [ 0, 0 ]
    numDigitos = 9
    if length(cpf) != numDigitos
        numDigitos = length(cpf) end
    soma = 0
    contador = numDigitos + 1
    for char in cpf
        soma += contador * parse(Int64, char)
        contador -= 1 end
    resto = soma % 11
    if resto > 1
        digitosVerificadores[1] = 11 - resto end
    soma = 0
    contador = numDigitos + 1
    for char in cpf
        soma += contador * parse(Int64, char)
        contador -= 1 end
    soma += digitosVerificadores[1] * contador
    resto = soma % 11
    if resto > 1
        digitosVerificadores[2] = 11 - resto end
    return digitosVerificadores end

println(" 1) reterNumeros(texto, n):\n 1.1) recebe um texto e um número inteiro, n;\n 1.2) retorna os n primeiros números disponíveis do texto recebido ou um texto vazio.")
println("  - reterNumeros(\"test123\", 3) --> \"", reterNumeros("test123", 3), "\""); # Expected result: "123"
println("  - reterNumeros(\"test123\", 2) --> \"", reterNumeros("test123", 2), "\""); # Expected result: "12"
println("  -   reterNumeros(\"test1\", 2) --> \"", reterNumeros("test1", 2), "\""); # Expected result: "1"
println("  -    reterNumeros(\"test\", 1) --> \"", reterNumeros("test", 1), "\""); # Expected result: ""
println("  -        reterNumeros(\"\", 2) --> \"", reterNumeros("", 2), "\""); # Expected result: ""
println()
println(" 2) calcularDigitos(cpf):\n 2.1) recebe um texto que será verificado por conteúdo numérico;\n 2.2) retorna false caso o texto recebido não possua conteúdo numérico.\n 2.3) retorna 2 inteiros caso um texto com conteúdo numérico seja recebido (apenas os 9 primeiros dígitos serão utilizados para cálculo dos dígitos verificadores).")
println("  - calcularDigitos(\"a\") --> ", calcularDigitos("a"))
println("  - calcularDigitos(\"0\") --> ", calcularDigitos("0"))
println("  - calcularDigitos(\"0\") --> ", calcularDigitos("123"))