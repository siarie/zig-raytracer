const std = @import("std");
const fmt = std.fmt;
const fs = std.fs;
const mem = std.mem;

const WIDTH = 256;
const HEIGHT = 256;

pub fn main() !void {
    var f = try fs.cwd().createFile("output.ppm", .{});
    defer f.close();

    const fw = f.writer();

    _ = try fw.write("P6\n");
    _ = try fw.print("{d} {d} {d}\n", .{ WIDTH, HEIGHT, 255 });

    for (0..HEIGHT) |y| {
        std.log.info("scan remaining {d} ", .{HEIGHT - y});
        for (0..WIDTH) |x| {
            const r: f32 = @as(f32, @floatFromInt(x)) / (WIDTH - 1);
            const g: f32 = @as(f32, @floatFromInt(y)) / (HEIGHT - 1);
            const b: f32 = 0.0;

            _ = try fw.writeByte(@intFromFloat(r * 255.999));
            _ = try fw.writeByte(@intFromFloat(g * 255.999));
            _ = try fw.writeByte(@intFromFloat(b * 255.999));
        }
    }

    std.log.info("done.", .{});
}
