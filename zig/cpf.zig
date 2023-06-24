// zig version: 0.11.0-dev.1929+4ea2f441d

const std = @import("std");
const assert = std.debug.assert;
const print = std.debug.print;

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = general_purpose_allocator.allocator();
    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);
    const sIOwriter = std.io.getStdOut().writer();
    if (std.mem.eql(u8, args[1], "-c") or std.mem.eql(u8, args[1], "--calcular")) {
        if (reterNumeros(args[2], 1).len > 0) {
            var digitosVerificadores = calcularDigitos(args[2], true);
            try sIOwriter.print("{!d}\n", .{digitosVerificadores});}
        else {
            print("{s}\n", .{"ERRO: o CPF deve possuir pelo menos um número."});}}
    else if (std.mem.eql(u8, args[1], "-v") or std.mem.eql(u8, args[1], "--verificar")) {
        if (reterNumeros(args[2], 1).len > 0) {
            var valid = verificar(args[2]);
            var cpf = reterNumeros(args[2], 11);
            print("O CPF {s}.{s}.{s}-{s} é ", .{
                cpf[0..3], cpf[3..6], cpf[6..9], cpf[9..11]});
            const v = "válido";
            if (valid) {
                print("{s}.\n", .{v});}
            else {
                print("in{s}.\n", .{v});}}
        else {
            print("{s}\n", .{"ERRO: o CPF deve possuir pelo menos um número."});}}
    else {
        print("{s}\n", .{" * Digite '-c' ou '--calcular' e um número de CPF para calcular os dígitos verificadores do CPF."});
        print("{s}\n", .{" * Digite '-v' ou '--verificar' e um número de CPF para verificar o CPF."});}}

fn verificar(cpf: []u8) bool {
    var cpfRecebido = reterNumeros(cpf, 11);
    var dvsRecebidos = [2]u16{
        @intCast(u16, cpfRecebido[9]) - '0',
        @intCast(u16, cpfRecebido[10]) - '0'};
    var dvsCalculados = calcularDigitos(cpfRecebido[0..9], false);
    if (dvsRecebidos[0] == dvsCalculados[0]
        and dvsRecebidos[1] == dvsCalculados[1]) {
        return true;}
    return false;}

fn calcularDigitos(cpf: []u8, loud: bool) [2]u16 {
    var DVS = [2]u16{ 0, 0 };
    var nums = reterNumeros(cpf, 9);
    var numsLength: u8 = 0;
    for (nums) |_| {
        numsLength += 1;}
    var multiplicador = numsLength + 1;
    var soma: u16 = 0;
    for (nums) |n| {
        var NumericCharIntValue: u16 = @intCast(u16, n) - '0';
        soma += multiplicador * NumericCharIntValue;
        multiplicador -= 1;}
    var resto = soma % 11;
    if (resto > 1) {
        DVS[0] = 11 - resto;}
    multiplicador = numsLength + 2;
    soma = 0;
    for (nums) |n| {
        var NumericCharIntValue: u16 = @intCast(u16, n) - '0';
        soma += multiplicador * NumericCharIntValue;
        multiplicador -= 1;}
    soma += DVS[0] * multiplicador;
    resto = soma % 11;
    if (resto > 1) {
        DVS[1] = 11 - resto;}
    var CPF = [_]u8{'0'} ** 9;
    var indice = 9 - numsLength;
    for (nums) |n| {
        CPF[indice] = n;
        indice += 1;}
    if (loud) {
        print("{s}.{s}.{s}-{d}{d}\n", .{ CPF[0..3], CPF[3..6], CPF[6..9], DVS[0], DVS[1] });
        print("{s}{d}{d}\n", .{ CPF, DVS[0], DVS[1] });}
    return DVS;}

fn reterNumeros(cpf: []u8, n: u8) []u8 {
    var numCounter: usize = 0;
    for (cpf) |byte| {
        if ((byte >= '0') and (byte <= '9')) {
            numCounter += 1;}}
    if (numCounter == 0) {
        return &[_]u8{};}
    var nums = [_]u8{'0'} ** 11;
    var start: usize = 0;
    if (numCounter < n) {
        start = n - numCounter;}
    var addedNums: usize = 0;
    for (cpf) |byte| {
        if (addedNums == n) {
            break;}
        if ((byte >= '0') and (byte <= '9')) {
            nums[start] = byte;
            addedNums += 1;
            start += 1;}}
    if (nums.len >= n) {
        return nums[0..n];}
    return &nums;}
