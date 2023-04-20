#!/usr/bin/env ruby

class Cpf
    attr_accessor :numero

    def initialize(numero = "")
        @numero = numero end

    def reterNumeros(n)
        numero = @numero.gsub(/\D/, '')
        numero = numero[0..n-1]
        return numero end end

if __FILE__ == $0
    cpf1 = Cpf.new
    cpf1.numero = "123.456"
    puts "reterNumeros(#{cpf1.numero}, 5) = #{cpf1.reterNumeros(5)}"
    puts ''

    cpf2 = Cpf.new
    cpf2.numero = "654.321"
    puts "reterNumeros(#{cpf2.numero}, 7) = #{cpf2.reterNumeros(7)}" end
