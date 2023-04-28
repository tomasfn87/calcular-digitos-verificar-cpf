// zig version: 0.11.0-dev.1929+4ea2f441d

const std = @import("std");
const assert = @import("std").debug.assert;
const print = @import("std").debug.print;

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = general_purpose_allocator.allocator();
    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);
    const sIOwriter = std.io.getStdOut().writer();
    var digitosVerificadores = calcularCpf(args[1]);
    try sIOwriter.print("{!d}\n", .{digitosVerificadores});
}

fn calcularCpf(cpf: []u8) [2]u16 {
    var DVS = [2]u16{ 0, 0 };
    var nums = reterNumeros(cpf, 9);
    var numsLength: u8 = 0;
    for (nums) |_| {
        numsLength += 1;
    }
    var multiplicador = numsLength + 1;
    var soma: u16 = 0;
    for (nums) |n| {
        var NumericCharIntValue = n - 48;
        soma += multiplicador * NumericCharIntValue;
        multiplicador -= 1;
    }
    var resto = soma % 11;
    if (resto > 1) {
        DVS[0] = 11 - resto;
    }
    multiplicador = numsLength + 2;
    soma = 0;
    for (nums) |n| {
        var NumericCharIntValue = n - 48;
        soma += multiplicador * NumericCharIntValue;
        multiplicador -= 1;
    }
    soma += DVS[0] * multiplicador;
    resto = soma % 11;
    if (resto > 1) {
        DVS[1] = 11 - resto;
    }
    var CPF = [_]u8{'0'} ** 9;
    var indice = 9 - numsLength;
    for (nums) |n| {
        CPF[indice] = n;
        indice += 1;
    }
    print("{s}.{s}.{s}-{d}{d}\n", .{ CPF[0..3], CPF[3..6], CPF[6..9], DVS[0], DVS[1] });
    print("{s}{d}{d}\n", .{ CPF, DVS[0], DVS[1] });
    return DVS;
}

fn reterNumeros(cpf: []u8, n: u8) []u8 {
    var numCounter: usize = 0;
    for (cpf) |byte| {
        if ((byte >= '0') and (byte <= '9')) {
            numCounter += 1;
        }
    }
    if (numCounter == 0) {
        return &[_]u8{};
    }
    var nums = cpf[0..numCounter];
    var i: usize = 0;
    for (cpf) |byte| {
        if ((byte >= '0') and (byte <= '9')) {
            nums[i] = byte;
            i += 1;
        }
    }
    if (nums.len >= n) {
        return nums[0..n];
    }
    return nums;
}
