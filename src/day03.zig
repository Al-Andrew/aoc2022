const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day03.txt");

pub fn getCounts(input: []const u8, countsMap: []u32) void {
    for (input) |char| {
        var idx: usize = 53;
        if (char >= 'a' and char <= 'z') {
            idx = char - 'a';
            countsMap[idx] += 1;
        } else if (char >= 'A' and char <= 'Z') {
            idx = char - 'A' + ('z'-'a') + 1;
            countsMap[idx] += 1;
        }
    }
}

pub fn main() !void {
    print("Day 3\n", .{});
    var lines = std.mem.split(u8, data, "\n");
    var total_score: usize = 0;
    while(lines.next()) |line| {
        var countsMapFirstHalf = [_]u32{0} ** (('z'-'a') + ('Z'-'A') + 2);
        var countsMapSecondHalf = [_]u32{0} ** (('z'-'a') + ('Z'-'A') + 2);
        var firstHalf = line[0..line.len/2];
        var secondHalf = line[line.len/2..];

        getCounts(firstHalf, countsMapFirstHalf[0..]);
        getCounts(secondHalf, countsMapSecondHalf[0..]);

        for (countsMapFirstHalf) |count, idx| {
            if (count >= 1 and countsMapSecondHalf[idx] >= 1) {
                // print("char: {}, score: {}\n", .{ if (idx <= 26) 'a' + idx else 'A' + idx - 26 , idx});
                total_score += idx + 1;
                break;
            }
        }
    }

    print("Part 1: {d}\n", .{total_score});
    // reset for day 3 part 2
    total_score = 0;
    lines = std.mem.split(u8, data, "\n");
    var groups = List(List([]const u8)).init(gpa);
    var idx: u32 = 0;
    while(lines.next()) |line| : (idx += 1) {
        if (idx % 3 == 0) {
            var group = List([]const u8).init(gpa);
            group.append(line) catch unreachable;
            groups.append(group) catch unreachable;
        } else {
            groups.items[groups.items.len - 1].append(line) catch unreachable;
        }
    }

    for(groups.items) |group| {
        var countsMap1 = [_]u32{0} ** (('z'-'a') + ('Z'-'A') + 2);
        var countsMap2 = [_]u32{0} ** (('z'-'a') + ('Z'-'A') + 2);
        var countsMap3 = [_]u32{0} ** (('z'-'a') + ('Z'-'A') + 2);

        getCounts(group.items[0], countsMap1[0..]);
        getCounts(group.items[1], countsMap2[0..]);
        getCounts(group.items[2], countsMap3[0..]);

        for (countsMap1) |count, i| {
            if (count >= 1 and countsMap2[i] >= 1 and countsMap3[i] >= 1) {
                total_score += i + 1;
                break;
            }
        }
    }

    print("Part 2: {d}\n", .{total_score});
}

// Useful stdlib functions
const tokenize = std.mem.tokenize;
const split = std.mem.split;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const min = std.math.min;
const min3 = std.math.min3;
const max = std.math.max;
const max3 = std.math.max3;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.sort;
const asc = std.sort.asc;
const desc = std.sort.desc;

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
