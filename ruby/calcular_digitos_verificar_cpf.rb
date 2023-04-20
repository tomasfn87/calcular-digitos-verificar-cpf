#!/usr/bin/env ruby

class Cpf
    attr_accessor :numero

    def initialize(numero = "")
        @numero = numero end

    def reterNumeros(n)
        numero = @numero.gsub(/\D/, '')
        numero = numero[0..n-1].rjust(n, '0')
        return numero end

    def calcularDigitos(loud=false)
        dvs = [ 0, 0 ]
        multiplicador = 10
        soma = 0
        i = 0
        nums = []
        while i < 9
            nums.append(Integer(reterNumeros(9)[i]))
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
        cpf = reterNumeros(9)
        if loud 
            puts "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{dvs[0]}#{dvs[1]}"
            puts "[#{dvs[0]}, #{dvs[1]}]" end
        return dvs end

    def verificar
        dvsRecebidos = [0, 0]
        cpfRecebido = reterNumeros(11)
        dvsRecebidos[0] = Integer(cpfRecebido[9])
        dvsRecebidos[1] = Integer(cpfRecebido[10])
        cpf = Cpf.new
        cpf.numero = cpfRecebido[0..8]
        dvsCalculados = cpf.calcularDigitos
        if dvsRecebidos[0] == dvsCalculados[0] and
            dvsRecebidos[1] == dvsCalculados[1]
            return true end
        return false end end

if __FILE__ == $0
    if ARGV[0] == '--demo'
        cpf1 = Cpf.new
        cpf1.numero = "123.456"
        cpf1.calcularDigitos(true)
        puts ''

        cpf2 = Cpf.new
        cpf2.numero = "654.321"
        cpf2.calcularDigitos(true)
        puts ''

        cpf3 = Cpf.new
        cpf3.numero = "47.74"
        cpf3.calcularDigitos(true)
    elsif ARGV[0] == '-c'
        cpf = Cpf.new
        cpf.numero = ARGV[1]
        cpf.calcularDigitos(true)
    elsif ARGV[0] == '-v'
        cpf = Cpf.new
        cpf.numero = ARGV[1]
        if cpf.verificar 
            puts "O CPF é válido"
        else
            puts "O CPF é inválido" end end end
 
