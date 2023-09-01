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

println(" 1) reterNumeros(texto, n):\n 1.1) recebe um texto e um número inteiro, n;\n 1.2) retorna os n primeiros números disponíveis do texto recebido ou um texto vazio.")
println("  - reterNumeros(\"test123\", 3) --> \"", reterNumeros("test123", 3), "\""); # Expected result: "123"
println("  - reterNumeros(\"test123\", 2) --> \"", reterNumeros("test123", 2), "\""); # Expected result: "12"
println("  -   reterNumeros(\"test1\", 2) --> \"", reterNumeros("test1", 2), "\""); # Expected result: "1"
println("  -    reterNumeros(\"test\", 1) --> \"", reterNumeros("test", 1), "\""); # Expected result: ""
println("  -        reterNumeros(\"\", 2) --> \"", reterNumeros("", 2), "\""); # Expected result: ""
