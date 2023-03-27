const std = @import("std");

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = general_purpose_allocator.allocator();
    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);
    const sIOwriter = std.io.getStdOut().writer();
    try sIOwriter.print("{!s}\n", .{reterNumeros(args[1], 11)});
    // var dvs = calcularCpf(args[1]);
    // try sIOwriter.print("{!s}\n", .{dvs});
}

// fn calcularCpf(cpf: []const u8) [2]u8 {
// var nums = reterNumeros(cpf, 11);
// std.debug.print("{!s}\n", .{nums});
// return [2]u8{ '0', '0' };
// }

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
