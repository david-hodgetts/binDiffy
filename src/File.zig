const std = @import("std");
const Allocator = std.mem.Allocator;
const print = std.debug.print;

pub fn readFileAsBytes(filePath:[]const u8, allocator: Allocator) ![]u8{

    const file = std.fs.cwd().openFile(filePath, .{ .read = true }) catch |err| {
        print("failed to open file {s} -> {}\n", .{ filePath, err });
        return err;
    };
    defer file.close();

    const stat = try file.stat();
    const fileSize = stat.size;
    var bytes: []u8 = try allocator.alloc(u8, stat.size);

    const readBytes = file.read(bytes) catch |err| {
        print("failed to read file {s} -> {}\n", .{ filePath, err });
        return err;
    };

    if(readBytes != fileSize){
        print("invalid byte count read, got {} expected {}\n", .{ readBytes, fileSize });
        return error.InvalidByteCount;
    }

    return bytes;
}

pub fn writeBytesToFile(bytes:[]const u8, filePath:[]const u8) !void{
    const file = std.fs.cwd().createFile(filePath, .{.read = false}) catch |err| {
        print("failed to create file {s} -> {}\n", .{ filePath, err });
        return err;
    };

    _ = file.writeAll(bytes) catch |err| {
        print("failed to write to file with path {s} -> {}\n", .{ filePath, err });
        return err;
    };
    defer file.close();
}