const std = @import("std");
const print = std.debug.print;
const File = @import("./File.zig");
const binDiff = @import("./BinDiffy.zig").binDiff;

pub fn main() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 3) {
        print("binDiffy aborting.\nincorrect argument count\ntakes 2 arguments -> file1 file2\n", .{});
        std.process.exit(1);
    }

    const filenameA = args[1];
    const filenameB = args[2];

    const bufA = try File.readFileAsBytes(filenameA, allocator);
    defer allocator.free(bufA);
    const bufB = try File.readFileAsBytes(filenameB, allocator);
    defer allocator.free(bufB);

    try binDiff(bufA, bufB);
}

