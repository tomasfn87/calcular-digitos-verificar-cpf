#!/usr/bin/env ruby

class Cpf
    attr_accessor :numero

    def initialize(numero = "")
        @numero = numero end

    def ReterNumeros(n=11)
        numero = @numero.gsub(/\D/, '')
        if numero.length < 1
            return "" end
        numero = numero[0..n-1].rjust(n, '0')
        return numero end

    def CalcularDigitos(loud=false)
        if ReterNumeros(1).length < 1
            if loud
                puts "Informe os 9 primeiros dígitos de um número de CPF para que o cálculo seja feito." end
            return end
        dvs = [ 0, 0 ]
        multiplicador = 10
        soma = 0
        i = 0
        nums = []
        while i < 9
            nums.append(Integer(ReterNumeros(9)[i]))
            i += 1 end
        for n in nums
            soma += multiplicador * n
            multiplicador -= 1 end
        resto = soma % 11
        if resto > 1
            dvs[0] = 11 - resto end
        nums.append(dvs[0])
        multiplicador = 11
        soma = 0
        for n in nums
            soma += multiplicador * n
            multiplicador -= 1 end
        resto = soma % 11
        if resto > 1
            dvs[1] = 11 - resto end 
        cpf = ReterNumeros(9)
        if loud 
            puts "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{dvs[0]}#{dvs[1]}"
            puts "#{cpf[0..8]}#{dvs[0]}#{dvs[1]}" end
        return dvs end

    def Verificar
        dvsRecebidos = [0, 0]
        cpfRecebido = ReterNumeros()
        if cpfRecebido.length < 1 
            return false end
        dvsRecebidos[0] = Integer(cpfRecebido[9])
        dvsRecebidos[1] = Integer(cpfRecebido[10])
        cpf = Cpf.new
        cpf.numero = cpfRecebido[0..8]
        dvsCalculados = cpf.CalcularDigitos
        if dvsRecebidos[0] == dvsCalculados[0] and
            dvsRecebidos[1] == dvsCalculados[1]
            return true end
        return false end end

if __FILE__ == $0
    if ARGV[0] == '--demo'
        cpf1 = Cpf.new
        cpf1.numero = "123.456"
        puts cpf1.CalcularDigitos(loud=true)
        puts ''
        cpf2 = Cpf.new
        cpf2.numero = "654.321"
        puts cpf2.CalcularDigitos(loud=true)
        puts ''
        cpf3 = Cpf.new
        cpf3.numero = "000.000.047"
        puts cpf3.CalcularDigitos(loud=true)
    elsif ARGV[0] == '-c'
        if ARGV[1] == nil
            puts "Informe os 9 primeiros dígitos de um número de CPF para que o cálculo seja feito."
        else
            cpf = Cpf.new
            cpf.numero = ARGV[1]
            cpf.CalcularDigitos(loud=true) end
    elsif ARGV[0] == '-v'
        if ARGV[1] == nil
            puts "Informe um CPF completo para que a verificação seja feita."
        else
            cpf = Cpf.new
            cpf.numero = ARGV[1]
            if cpf.Verificar 
                puts "O CPF é válido"
            else
                puts "O CPF é inválido" end end end end 
