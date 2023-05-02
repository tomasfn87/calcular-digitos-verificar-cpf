package main

import "core:fmt"
import "core:strings"

main :: proc() {
    fmt.println(reterNumeros("a1", 2))   // "01"
    fmt.println(reterNumeros("b23", 2))  // "23"
    fmt.println(reterNumeros("c456", 2)) // "45"
    fmt.println(calcularDigitos("123"))  // [6, 0]
    fmt.println(verificar("12359"))      // false
    fmt.println(verificar("12360"))}     // true

reterNumeros :: proc(cpf: string, n: int) -> string {
    total : int = 0
    Cpf : string = ""
    for i := 0; i < len(cpf); i += 1 {
        if cpf[i] >= '0' && cpf[i] <= '9' {
            Cpf = strings.join({ Cpf, cpf[i:i+1] }, "")
            total += 1}
        if total == n {
            break}}
    for len(Cpf) < n {
        Cpf = strings.join({ "0", Cpf }, "")}
    return Cpf}

calcularDigitos :: proc(cpf: string) -> [dynamic]u8 {
    if len(reterNumeros(cpf, 1)) < 1 {
        return [dynamic]u8{}}
    dvs := [dynamic]u8{ ---, --- }
    multiplicador : u8 = 10
    resto, soma : u8 = 0, 0
    Cpf := reterNumeros(cpf, 9)
    for i := 0; i < len(Cpf); i += 1 {
        soma += (Cpf[i] - 48) * multiplicador
        multiplicador -= 1}
    resto = soma % 11
    if resto > 1 {
        dvs[0] = 11 - resto}
    multiplicador = 11
    resto, soma = 0, 0
    for i := 0; i < len(Cpf); i += 1 {
        soma += (Cpf[i] - 48) * multiplicador
        multiplicador -= 1}
    soma += dvs[0] * multiplicador
    resto = soma % 11
    if resto > 1 {
        dvs[1] = 11 - resto}
    return dvs}

verificar :: proc(cpf: string) -> bool {
    if len(reterNumeros(cpf, 1)) < 1 {
        return false}
    dvs_recebidos := [2]u8{
        reterNumeros(cpf, 11)[9]-48,
        reterNumeros(cpf, 11)[10]-48}
    dvs_calculados := calcularDigitos(reterNumeros(cpf, 11)[0:9])
    if dvs_recebidos[0] == dvs_calculados[0] &&
        dvs_recebidos[1] == dvs_calculados[1] {
        return true}
    return false}
