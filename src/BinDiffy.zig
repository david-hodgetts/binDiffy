const std = @import("std");
const print = std.debug.print;

pub fn binDiff(bufA: []const u8, bufB: []const u8) !void {
    const len = std.math.min(bufA.len, bufB.len);
    var offset: usize = 0;
    var out = std.io.getStdOut().writer();

    while (offset < len) : (offset += 1) {
        const byteA = bufA[offset];
        const byteB = bufB[offset];
        if (byteA != byteB) {
            try out.print("{} {x} {x}\n", .{ offset, byteA, byteB });
        }
    }

    // handle files with differing sizes
    if (bufA.len > len) {
        try out.print("{} {x} EOF\n", .{ len, bufA[len] });
    }

    if (bufB.len > len) {
        try out.print("{} EOF {x}\n", .{ len, bufB[len] });
    }
}
