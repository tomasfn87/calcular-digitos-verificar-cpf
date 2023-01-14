-- LuaJIT 2.0.5 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/
local params = {...}

function Verificar(cpf)
    print("               CPF:", cpf)
    digitos = ObterDigitos(cpf, 11)
    if table.getn(digitos) == 0 then
        return false end
    dvCpf1, dvCpf2 = digitos[10], digitos[11]
    print("       Dígitos CPF:", dvCpf1, dvCpf2)
    c = string.sub(ReterNumeros(cpf, 11), 1, 9)
    dvCalc1, dvCalc2 = CalcularDigitos(c)
    print("Dígitos calculados:", dvCalc1, dvCalc2)
    if dvCpf1 == dvCalc1 and dvCpf2 == dvCalc2 then
        return true end
    return false end

function ObterDigitos(cpf, n)
    digitos = {}
    cpf = ReterNumeros(cpf, n)
    if cpf == "" then
        return digitos end
    for i=1, n, 1 do
        d = ParseInt(string.sub(cpf, i, i))
        table.insert(digitos, d) end
    return digitos end

function ReterNumeros(cpf, n)
    cpf = string.gsub(cpf, "%D", "")
    if cpf == "" then
        return cpf end
    if string.len(cpf) < n then
        cpf = string.rep("0", n - string.len(cpf))..cpf  end
    return cpf end

function CalcularDigitos(cpf)
    digitos = ObterDigitos(cpf, 9)
    if table.getn(digitos) == 0 then
        return false end
    dv1 = CalcularDigito(digitos)
    table.insert(digitos, dv1)
    dv2 = CalcularDigito(digitos)
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
    multiplicador = table.getn(digitos) + 1
    soma = 0
    for i=1, table.getn(digitos), 1 do
        soma = soma + (multiplicador * digitos[i])
        multiplicador = multiplicador - 1 end
    resto = soma % 11
    if resto < 2 then
        return 0 end
    return 11 - resto end

-- CPF inválido p/ verificação (sem números)
-- a = "a"
-- print(Verificar(a)) -- expected: false
-- print(CalcularDigitos(a))

-- CPF válido p/ verificacão (o número é inválido)
-- print()
-- b = "123a"
-- print(Verificar(b)) -- expected: false
-- print(CalcularDigitos(b))

-- CPF válido p/ verificação (o número é válido)
-- print()
-- c = "123-60"
-- print(Verificar(c)) -- expected: true
-- print(CalcularDigitos(c))

if params[1] == 'c' then
    print(CalcularDigitos(params[2])) end
if params[1] == 'v' then
    print(Verificar(params[2])) end
