using Printf

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
    multiplicador, soma = 10, 0
    for char in cpf
        soma += multiplicador * parse(Int64, char)
        multiplicador -= 1 end
    resto = soma % 11
    if resto > 1
        digitosVerificadores[1] = 11 - resto end
    multiplicador, soma = 11, 0
    for char in cpf
        soma += multiplicador * parse(Int64, char)
        multiplicador -= 1 end
    soma += digitosVerificadores[1] * multiplicador
    resto = soma % 11
    if resto > 1
        digitosVerificadores[2] = 11 - resto end
    return digitosVerificadores end

function formatar(CPF)
    cpf = reterNumeros(CPF, 11)
    if length(cpf) < 1
        return "" end
    cpfF = @sprintf "%s.%s.%s-%s" cpf[1:3] cpf[4:6] cpf[7:9] cpf[10:11]
    return cpfF end

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

if length(ARGS) == 1 && ARGS[1] == "--demo"
    println(" 1) reterNumeros(texto, n):\n 1.1) recebe um texto e um número inteiro, n;\n 1.1.1) caso possua conteúdo numérico retorna os n primeiros números disponíveis do texto recebido, preenchendo o número com zeros à esquerda caso o texto recebido possuir menos de n algarismos;\n 1.1.2) caso contrário, retorna um texto vazio.")
    println()
    println("  - reterNumeros(\"test123\", 3) --> \"", reterNumeros("test123", 3), "\""); # Expected result: "123"
    println("  - reterNumeros(\"test123\", 2) --> \"", reterNumeros("test123", 2), "\""); # Expected result: "12"
    println("  -   reterNumeros(\"test1\", 2) --> \"", reterNumeros("test1", 2), "\"");   # Expected result: "01"
    println("  -    reterNumeros(\"test\", 1) --> \"", reterNumeros("test", 1), "\"");    # Expected result: ""
    println("  -        reterNumeros(\"\", 2) --> \"", reterNumeros("", 2), "\"");        # Expected result: ""
    println()
    println()
    println(" 2) formatar(CPF):\n 2.1) recebe um texto do qual é esperado um número de CPF, com ou sem formatação;\n 2.1.1) caso possua conteúdo numérico, os 11 primeiros dígitos serão usados para exibir o número de CPF formatado, e, se não forem encontrados 11 caracteres numéricos, o número será preenchido com zeros à esquerda;\n 2.1.2) caso contrário, retorna um texto vazio.")
    println()
    println("  -           formatar(\"test\") --> \"", formatar("test"), "\"");           # Expected result: ""
    println("  -              formatar(\"1\") --> \"", formatar("1"), "\"");              # Expected result: "000.000.000-01"
    println("  -    formatar(\"98765432100\") --> \"", formatar("98765432100"), "\"");    # Expected result: "987.654.321-00"
    println()
    println()
    println(" 3) calcularDigitos(CPF):\n 3.1) recebe um texto que será verificado por conteúdo numérico;\n 3.2) retorna false caso o texto recebido não possua conteúdo numérico.\n 3.3) retorna 2 inteiros caso um texto com conteúdo numérico seja recebido (apenas os 9 primeiros dígitos serão utilizados para cálculo dos dígitos verificadores).")
    println()
    println("  -       calcularDigitos(\"a\") --> ", calcularDigitos("a"))                # Expected result: false
    println("  -       calcularDigitos(\"0\") --> ", calcularDigitos("0"))                # Expected result: [0, 0]
    println("  -     calcularDigitos(\"123\") --> ", calcularDigitos("123"))              # Expected result: [6, 0]
    println()
    println()
    println(" 4) verificar(CPF):\n 4.1) recebe um texto que será verificado por conteúdo numérico;\n 4.1.1) retorna false caso o texto recebido não possua conteúdo numérico.\n 4.1.2) no caso de conteúdo numérico detectado, o número é tido como um número de CPF completo:\n 4.1.2.1) caso possua menos do que 11 caracteres numéricos, o CPF será completado com zeros à esquerda;\n 4.1.2.2) os dois últimos dígitos são considerados dígitos verificadores, e sobre os nove dígitos restantes é feito o cálculo de dígitos verificadores:\n 4.1.2.2.1) se os 2 últimos dígitos recebidos forem iguais aos dígitos calculados, retorna true;\n 4.1.2.2.2) caso contrário, retorna false.")
    println()
    println("  -             verificar(\"a\") --> ", verificar("a"))                      # Expected result: false
    println("  -             verificar(\"0\") --> ", verificar("0"))                      # Expected result: true
    println("  -         verificar(\"12360\") --> ", verificar("12360"))                  # Expected result: true
elseif length(ARGS) == 2
    if ARGS[1] == "--verificar" || ARGS[1] == "-v"
        if length(reterNumeros(ARGS[2], 1)) < 1
            println("ERRO: o CPF informado não possui caracteres numéricos.")
            return end
        valid = verificar(ARGS[2])
        if !valid
            @printf "O CPF %s é " formatar(ARGS[2])
            printstyled("inválido"; color = :red)
            println(".")
        else
            @printf "O CPF %s é " formatar(ARGS[2])
            printstyled("válido"; color = :green)
            println(".") end
    elseif ARGS[1] == "--calcular" || ARGS[1] == "-c"
        if length(reterNumeros(ARGS[2], 1)) < 1
            println("ERRO: o CPF informado não possui caracteres numéricos.")
            return end
        dvs = calcularDigitos(ARGS[2])
        cpfCompleto = @sprintf "%s%d%d" ARGS[2] dvs[1] dvs[2]
        @printf "CPF informado: %s\n" formatar(cpfCompleto)[1:11]
        @printf "CPF completo:  %s\n" formatar(cpfCompleto)
        @printf "               %s\n" reterNumeros(cpfCompleto, 11)
        println(dvs)
    elseif ARGS[1] == "--formatar" || ARGS[1] == "-f"
        if length(reterNumeros(ARGS[2], 1)) < 1
            println("ERRO: o CPF informado não possui caracteres numéricos.")
            return end
        println("CPF formatado: ", formatar(ARGS[2])) end
else
    println("Escolha uma das opções abaixo:")
    println(" 1) '--demo' para visualizar uma demonstração do programa;")
    println(" 2) '--calcular' ou '-c' e número de CPF para efetuar o cálculo dos dígitos verificadores do mesmo;")
    println(" 3) '--verificar' ou '-v' e número de CPF para efetuar a verificação do mesmo;")
    println(" 4) '--formatar' ou '-f' e número de CPF para que o mesmo seja impresso com formatação.") end
