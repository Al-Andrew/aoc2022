const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day02.txt");

pub const Move = enum (u8) {
    ROCK = 0,
    PAPER = 1,
    SCISSORS = 2,
};

pub const Outcome = enum (u8) {
    LOSS = 0,
    DRAW = 1,
    WIN = 2,
};

pub fn getOpponentMove(opponent: u8) Move {
    switch (opponent) {
        'A' => return Move.ROCK,
        'B' => return Move.PAPER,
        'C' => return Move.SCISSORS,
        else => unreachable,
    }
    unreachable;
}

pub fn getYourMove(you: u8) Move {
    switch (you) {
        'X' => return Move.ROCK,
        'Y' => return Move.PAPER,
        'Z' => return Move.SCISSORS,
        else => unreachable,
    }
    unreachable;
}

pub fn getStrategyOutcome(outcome: u8) Outcome {
    switch (outcome) {
        'X' => return Outcome.LOSS,
        'Y' => return Outcome.DRAW,
        'Z' => return Outcome.WIN,
        else => unreachable,
    }
    unreachable;
}

pub fn getOutcomeForMoves(opponent: Move, you: Move) Outcome {
    return switch (opponent) {
        Move.ROCK => switch (you) {
            Move.ROCK => return Outcome.DRAW,
            Move.PAPER => return Outcome.WIN,
            Move.SCISSORS => return Outcome.LOSS,
        },
        Move.PAPER => switch (you) {
            Move.ROCK => return Outcome.LOSS,
            Move.PAPER => return Outcome.DRAW,
            Move.SCISSORS => return Outcome.WIN,
        },
        Move.SCISSORS => switch (you) {
            Move.ROCK => Outcome.WIN,
            Move.PAPER => Outcome.LOSS,
            Move.SCISSORS => Outcome.DRAW,
        }
    };
}

pub fn GetMoveForOutcome(opponent: Move, outcome: Outcome) Move {
    return switch (opponent) {
        Move.ROCK => switch (outcome) {
            Outcome.LOSS => return Move.SCISSORS,
            Outcome.DRAW => return Move.ROCK,
            Outcome.WIN => return Move.PAPER,
        },
        Move.PAPER => switch (outcome) {
            Outcome.LOSS => return Move.ROCK,
            Outcome.DRAW => return Move.PAPER,
            Outcome.WIN => return Move.SCISSORS,
        },
        Move.SCISSORS => switch (outcome) {
            Outcome.LOSS => return Move.PAPER,
            Outcome.DRAW => return Move.SCISSORS,
            Outcome.WIN => return Move.ROCK,
        },
    };
}

pub fn main() !void {
    print("Day 2\n", .{});
    var lines = std.mem.split(u8, data, "\n");
    const shapePoints = [_]i32{ 1, 2, 3};
    const roundPoints = [_]i32{ 0, 3, 6};

    var totalScore: i32 = 0;
    while(lines.next()) |line| {
        const opponent: Move = getOpponentMove(line[0]);
        const you: Move = getYourMove(line[2]);
        const outcome = getOutcomeForMoves(opponent, you);
        const roundScore = shapePoints[@enumToInt(you)] + roundPoints[@enumToInt(outcome)];
        totalScore += roundScore;
    }

    print("Part 1: {d}\n", .{totalScore});
    // reset for part2
    lines = std.mem.split(u8, data, "\n");
    totalScore = 0;
    while(lines.next()) |line| {
        const opponent: Move = getOpponentMove(line[0]);
        const outcome: Outcome = getStrategyOutcome(line[2]);
        const you = GetMoveForOutcome(opponent, outcome);
        const roundScore = shapePoints[@enumToInt(you)] + roundPoints[@enumToInt(outcome)];
        totalScore += roundScore;
    }
    print("Part 2: {d}\n", .{totalScore});
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
