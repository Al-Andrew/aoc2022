const std = @import("std");
const math = @import("math");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day01.txt");

fn lessThan(context: void, a: i32, b: i32) std.math.Order { _ = context; return std.math.order(a, b); }

pub fn main() !void {
    std.debug.print("Day 01\n", .{});
    var elves = std.PriorityQueue(i32, void, lessThan).init(gpa, {});
    defer elves.deinit();
    
    var current_elf: i32 = 0;
    
    var lines = split(u8, data, "\n");
    while (lines.next()) |line| {
        if(line.len == 0) {
            try elves.add(-current_elf); // NOTE (Al): adding the values negated because I don't know hoe to make a comparator function to sort them the other way :derp:
            current_elf = 0;
            continue;
        }
        current_elf += try std.fmt.parseInt(i32, line, 10);
    }
    try elves.add(-current_elf);

    var top1 = elves.remove();
    var top3 = top1 + elves.remove() + elves.remove();

    std.debug.print("Part 1: {d}\n", .{top1});
    std.debug.print("Part 2: {d}\n", .{top3});
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
