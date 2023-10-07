module cpf;

import std.conv;
import std.regex;

string reter_numeros(string texto, uint n) {
    if (texto.length < 1 || n < 1) {
        return "";}
    auto REnotNums = regex(r"\D", "g");
    string apenas_nums = replace(texto, REnotNums, "");
    if (apenas_nums.length < 1) {
        return "";}
    if (apenas_nums.length > n) {
        apenas_nums = apenas_nums[0..n];}
    while (apenas_nums.length < n) {
        apenas_nums = "0" ~ apenas_nums;}
    return apenas_nums;}

uint[2] calcular_digitos(string cpf) {
    string CPF = reter_numeros(cpf, 9);
    if (CPF.length < 1 ) {
        throw new Exception(
            "ERRO: CPF inválido: o CPF informado não contém números.");}
    uint[2] dvs;
    dvs[0] = calcular_digito(CPF);
    CPF = CPF ~ dvs[0].to!string;
    dvs[1] = calcular_digito(CPF);
    return dvs;}

uint calcular_digito(string digitos) {
    uint dv, soma, resto;
    ulong multiplicador = digitos.length + 1;
    foreach (char c; digitos) {
        soma += (uint(c) - '0') * multiplicador;
        multiplicador -= 1;}
    resto = soma % 11;
    if (resto > 1) {
        dv = 11 - resto;}
    return dv;}

bool verificar(string cpf) {
    string CPF = reter_numeros(cpf, 11);
    if (CPF.length < 1 ) {
        throw new Exception(
            "ERRO: CPF inválido: o CPF informado não contém números.");}
    uint[2] dvs_calculados = calcular_digitos(CPF[0..9]);
    uint[2] dvs_recebidos = [
        uint(CPF[9]) - '0', uint(CPF[10]) - '0' ];
    if (dvs_calculados[0] == dvs_recebidos[0] &&
        dvs_calculados[1] == dvs_recebidos[1]) {
        return true;}
    return false;}
