-- LuaJIT 2.0.5 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/
local params = {...}

function Verificar(cpf)
    local c = ReterNumeros(cpf, 11)
    if string.len(c) < 1 then
        print("ERRO: o CPF deve conter pelo menos um caracter numérico.")
        return end
    local Cpf = string.sub(c, 1, 3)
        .."."..string.sub(c, 4, 6)
        .."."..string.sub(c, 7, 9)
        .."-"..string.sub(c, 10, 11)
    print("               CPF:", Cpf)
    local digitos = ObterDigitos(cpf, 11)
    local dvCpf1, dvCpf2 = digitos[10], digitos[11]
    print("       Dígitos CPF:", dvCpf1, dvCpf2)
    c = string.sub(ReterNumeros(cpf, 11), 1, 9)
    local dvCalc1, dvCalc2 = CalcularDigitos(c)
    print("Dígitos calculados:", dvCalc1, dvCalc2)
    if dvCpf1 == dvCalc1 and dvCpf2 == dvCalc2 then
        return true end
    return false end

function ObterDigitos(cpf, n)
    local digitos = {}
    local Cpf = ReterNumeros(cpf, n)
    if Cpf == "" then
        return digitos end
    for i=1, n, 1 do
        local d = ParseInt(string.sub(Cpf, i, i))
        table.insert(digitos, d) end
    return digitos end

function ReterNumeros(cpf, n)
    local Cpf = string.gsub(cpf, "%D", "")
    if Cpf == "" then
        return Cpf end
    while string.len(Cpf) < n do
        Cpf = string.rep("0", n - string.len(Cpf))..Cpf end
    return Cpf end

function CalcularDigitos(cpf)
    if string.len(ReterNumeros(cpf, 1)) < 1 then
        print("ERRO: o CPF deve conter pelo menos um caracter numérico.")
        return end
    local digitos = ObterDigitos(cpf, 9)
    local dv1 = CalcularDigito(digitos)
    table.insert(digitos, dv1)
    local dv2 = CalcularDigito(digitos)
    local Cpf = ReterNumeros(cpf, 9)
    local dvs = string.format("%d%d", dv1, dv2)
    print(string.sub(Cpf, 1, 3).."."..string.sub(Cpf, 4, 6)
        .."."..string.sub(Cpf, 7, 9).."-"..dvs)
    print(Cpf..dvs)
    return dv1, dv2 end

function ParseInt(str)
    function hasInteger(str)
        return not (str == "" or str:match("%D")) end
    function hasFloat(str)
        return not not (str:match("%d.%d")) end
    if hasInteger(str) or hasFloat(str) then
        return tonumber(str) end
    return false end

function CalcularDigito(digitos)
    local multiplicador = table.getn(digitos) + 1
    local soma = 0
    for i=1, table.getn(digitos), 1 do
        soma = soma + (multiplicador * digitos[i])
        multiplicador = multiplicador - 1 end
    local resto = soma % 11
    if resto > 1 then
        return 11 - resto end
    return 0 end

if params[1] == '-c' or params[1] == '--calcular' then
    print(CalcularDigitos(params[2])) end
if params[1] == '-v' or params[1] == '--verificar' then
    print(Verificar(params[2])) end
if params[1] == '--demo' then
    -- CPF inválido p/ verificação (sem números)
    local a = "a"
    print('1) CPF = "'..a..'"')
    print('   - Verificar("'..a..'")')
    print(Verificar(a)) -- expected: false
    print('\n   - CalcularDigitos("'..a..'")')
    print(CalcularDigitos(a))
   -- CPF válido p/ verificacão (o número é inválido)
   print("\n")
    local b = "123a"
    print('2) CPF = "'..b..'"')
    print('   - Verificar("'..b..'")')
    print(Verificar(b)) -- expected: false
    print('\n   - CalcularDigitos("'..b..'")')
    print(CalcularDigitos(b))
    -- CPF válido p/ verificação (o número é válido)
    print("\n")
    local c = "123-60"
    print('3) CPF = "'..c..'"')
    print('   - Verificar("'..c..'")')
    print(Verificar(c)) -- expected: true
    print('\n   - CalcularDigitos("'..c..'")')
    print(CalcularDigitos(c)) end
