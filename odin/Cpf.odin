package main

import "core:fmt"
import "core:os"
import "core:strings"

main :: proc() {
    args := os.args
    if len(args) > 2 {
        if len(reterNumeros(args[2], 1)) > 0 {
            if args[1] == "-c" || args[1] == "--calcular" {
                dvs := calcularDigitos(args[2])
                fmt.printf("[ %d, %d ]\n", dvs[0], dvs[1])}
            else if args[1] == "-v" || args[1] == "--verificar" {
                valid : bool = verificar(args[2])
                cpf : string = reterNumeros(args[2], 11)
                fmt.printf("O CPF %s.%s.%s-%s é ",
                    cpf[0:3], cpf[3:6], cpf[6:9], cpf[9:11])
                if (!valid) {
                    fmt.print("in")}
                fmt.println("válido.")}
            else {
                imprimirInstrucoes()}}
        else {
            fmt.println("ERRO: o CPF deve possuir pelo menos um número.")}}
    else {
        imprimirInstrucoes()}}

reterNumeros :: proc(text: string, n: int) -> string {
    total : int = 0
    onlyNums : string = ""
    for i := 0; i < len(text); i += 1 {
        if text[i] >= '0' && text[i] <= '9' {
            onlyNums = strings.join({ onlyNums, text[i:i+1] }, "")
            total += 1}
        if total == n {
            break}}
    for len(onlyNums) < n {
        onlyNums = strings.join({ "0", onlyNums }, "")}
    return onlyNums}

calcularDigitos :: proc(cpf: string) -> [2]u16 {
    if len(reterNumeros(cpf, 1)) < 1 {
        return [2]u16{}}
    dvs := [2]u16{ 0, 0 }
    multiplicador, resto, soma : u16 = 10, 0, 0
    Cpf := reterNumeros(cpf, 9)
    for i := 0; i < 9; i += 1 {
        digito := Cpf[i] - '0'
        soma += u16(digito) * multiplicador
        multiplicador -= 1}
    resto = soma % 11
    if resto > 1 {
        dvs[0] = 11 - resto}
    multiplicador, resto, soma = 11, 0, 0
    for i := 0; i < len(Cpf); i += 1 {
        digito := Cpf[i] - '0'
        soma += u16(digito) * multiplicador
        multiplicador -= 1}
    soma += dvs[0] * multiplicador
    resto = soma % 11
    if resto > 1 {
        dvs[1] = 11 - resto}
    return dvs}

verificar :: proc(cpf: string) -> bool {
    if len(reterNumeros(cpf, 1)) < 1 {
        return false}
    dvs_recebidos := [2]u16{
        u16(reterNumeros(cpf, 11)[9] - '0'),
        u16(reterNumeros(cpf, 11)[10] - '0')}
    dvs_calculados := calcularDigitos(reterNumeros(cpf, 11)[0:9])
    if dvs_recebidos[0] == dvs_calculados[0] &&
        dvs_recebidos[1] == dvs_calculados[1] {
        return true}
    return false}

imprimirInstrucoes :: proc() {
    fmt.print(` * Digite '-c' ou '--calcular' e um número de CPF sem os `) 
    fmt.print(`dígitos verificadores (9 números) para calcular os `)
    fmt.println(`dígitos verificadores do CPF.`)
    fmt.print(` * Digite '-v' ou '--verificar' e um número de CPF `)
    fmt.println(`completo (11 números) para verificar o CPF.`)}
