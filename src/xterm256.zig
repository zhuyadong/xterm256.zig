const std = @import("std");
const builtin = @import("builtin");
const FieldEnum = std.meta.FieldEnum;
const StructField = std.builtin.Type.StructField;
const nameCast = std.enums.nameCast;
const assert = std.debug.assert;

const BasicColor = enum(u8) {
    black = 30, //rgb(0,0,0)
    red = 31, //rgb(128,0,0)
    green = 32, //rgb(0,128,0)
    yellow = 33, //rgb(128,128,0)
    blue = 34, //rgb(0,0,128)
    magenta = 35, //rgb(128,0,128)
    cyan = 36, //rgb(0,128,128)
    white = 37, //rgb(192,192,192)
    bright_black = 90, //rgb(128,128,128)
    bright_red = 91, //rgb(255,0,0)
    bright_green = 92, //rgb(0,255,0)
    bright_yellow = 93, //rgb(255,255,0)
    bright_blue = 94, //rgb(0,0,255)
    bright_magenta = 95, //rgb(255,0,255)
    bright_cyan = 96, //rgb(0,255,255)
    bright_white = 97, //rgb(255,255,255)

    pub fn ansiCode(self: BasicColor, is_foreground: bool) u8 {
        const ret: u8 = @intFromEnum(self);
        return if (is_foreground) ret else ret + 10;
    }
};

const XtermColor = enum(u8) {
    x016 = 16, //rgb(0, 0, 0)
    x017 = 17, //rgb(0, 0, 95)
    x018 = 18, //rgb(0, 0, 135)
    x019 = 19, //rgb(0, 0, 175)
    x020 = 20, //rgb(0, 0, 215)
    x021 = 21, //rgb(0, 0, 255)
    x022 = 22, //rgb(0, 95, 0)
    x023 = 23, //rgb(0, 95, 95)
    x024 = 24, //rgb(0, 95, 135)
    x025 = 25, //rgb(0, 95, 175)
    x026 = 26, //rgb(0, 95, 215)
    x027 = 27, //rgb(0, 95, 255)
    x028 = 28, //rgb(0, 135, 0)
    x029 = 29, //rgb(0, 135, 95)
    x030 = 30, //rgb(0, 135, 135)
    x031 = 31, //rgb(0, 135, 175)
    x032 = 32, //rgb(0, 135, 215)
    x033 = 33, //rgb(0, 135, 255)
    x034 = 34, //rgb(0, 175, 0)
    x035 = 35, //rgb(0, 175, 95)
    x036 = 36, //rgb(0, 175, 135)
    x037 = 37, //rgb(0, 175, 175)
    x038 = 38, //rgb(0, 175, 215)
    x039 = 39, //rgb(0, 175, 255)
    x040 = 40, //rgb(0, 215, 0)
    x041 = 41, //rgb(0, 215, 95)
    x042 = 42, //rgb(0, 215, 135)
    x043 = 43, //rgb(0, 215, 175)
    x044 = 44, //rgb(0, 215, 215)
    x045 = 45, //rgb(0, 215, 255)
    x046 = 46, //rgb(0, 255, 0)
    x047 = 47, //rgb(0, 255, 95)
    x048 = 48, //rgb(0, 255, 135)
    x049 = 49, //rgb(0, 255, 175)
    x050 = 50, //rgb(0, 255, 215)
    x051 = 51, //rgb(0, 255, 255)
    x052 = 52, //rgb(95, 0, 0)
    x053 = 53, //rgb(95, 0, 95)
    x054 = 54, //rgb(95, 0, 135)
    x055 = 55, //rgb(95, 0, 175)
    x056 = 56, //rgb(95, 0, 215)
    x057 = 57, //rgb(95, 0, 255)
    x058 = 58, //rgb(95, 95, 0)
    x059 = 59, //rgb(95, 95, 95)
    x060 = 60, //rgb(95, 95, 135)
    x061 = 61, //rgb(95, 95, 175)
    x062 = 62, //rgb(95, 95, 215)
    x063 = 63, //rgb(95, 95, 255)
    x064 = 64, //rgb(95, 135, 0)
    x065 = 65, //rgb(95, 135, 95)
    x066 = 66, //rgb(95, 135, 135)
    x067 = 67, //rgb(95, 135, 175)
    x068 = 68, //rgb(95, 135, 215)
    x069 = 69, //rgb(95, 135, 255)
    x070 = 70, //rgb(95, 175, 0)
    x071 = 71, //rgb(95, 175, 95)
    x072 = 72, //rgb(95, 175, 135)
    x073 = 73, //rgb(95, 175, 175)
    x074 = 74, //rgb(95, 175, 215)
    x075 = 75, //rgb(95, 175, 255)
    x076 = 76, //rgb(95, 215, 0)
    x077 = 77, //rgb(95, 215, 95)
    x078 = 78, //rgb(95, 215, 135)
    x079 = 79, //rgb(95, 215, 175)
    x080 = 80, //rgb(95, 215, 215)
    x081 = 81, //rgb(95, 215, 255)
    x082 = 82, //rgb(95, 255, 0)
    x083 = 83, //rgb(95, 255, 95)
    x084 = 84, //rgb(95, 255, 135)
    x085 = 85, //rgb(95, 255, 175)
    x086 = 86, //rgb(95, 255, 215)
    x087 = 87, //rgb(95, 255, 255)
    x088 = 88, //rgb(135, 0, 0)
    x089 = 89, //rgb(135, 0, 95)
    x090 = 90, //rgb(135, 0, 135)
    x091 = 91, //rgb(135, 0, 175)
    x092 = 92, //rgb(135, 0, 215)
    x093 = 93, //rgb(135, 0, 255)
    x094 = 94, //rgb(135, 95, 0)
    x095 = 95, //rgb(135, 95, 95)
    x096 = 96, //rgb(135, 95, 135)
    x097 = 97, //rgb(135, 95, 175)
    x098 = 98, //rgb(135, 95, 215)
    x099 = 99, //rgb(135, 95, 255)
    x100 = 100, //rgb(135, 135, 0)
    x101 = 101, //rgb(135, 135, 95)
    x102 = 102, //rgb(135, 135, 135)
    x103 = 103, //rgb(135, 135, 175)
    x104 = 104, //rgb(135, 135, 215)
    x105 = 105, //rgb(135, 135, 255)
    x106 = 106, //rgb(135, 175, 0)
    x107 = 107, //rgb(135, 175, 95)
    x108 = 108, //rgb(135, 175, 135)
    x109 = 109, //rgb(135, 175, 175)
    x110 = 110, //rgb(135, 175, 215)
    x111 = 111, //rgb(135, 175, 255)
    x112 = 112, //rgb(135, 215, 0)
    x113 = 113, //rgb(135, 215, 95)
    x114 = 114, //rgb(135, 215, 135)
    x115 = 115, //rgb(135, 215, 175)
    x116 = 116, //rgb(135, 215, 215)
    x117 = 117, //rgb(135, 215, 255)
    x118 = 118, //rgb(135, 255, 0)
    x119 = 119, //rgb(135, 255, 95)
    x120 = 120, //rgb(135, 255, 135)
    x121 = 121, //rgb(135, 255, 175)
    x122 = 122, //rgb(135, 255, 215)
    x123 = 123, //rgb(135, 255, 255)
    x124 = 124, //rgb(175, 0, 0)
    x125 = 125, //rgb(175, 0, 95)
    x126 = 126, //rgb(175, 0, 135)
    x127 = 127, //rgb(175, 0, 175)
    x128 = 128, //rgb(175, 0, 215)
    x129 = 129, //rgb(175, 0, 255)
    x130 = 130, //rgb(175, 95, 0)
    x131 = 131, //rgb(175, 95, 95)
    x132 = 132, //rgb(175, 95, 135)
    x133 = 133, //rgb(175, 95, 175)
    x134 = 134, //rgb(175, 95, 215)
    x135 = 135, //rgb(175, 95, 255)
    x136 = 136, //rgb(175, 135, 0)
    x137 = 137, //rgb(175, 135, 95)
    x138 = 138, //rgb(175, 135, 135)
    x139 = 139, //rgb(175, 135, 175)
    x140 = 140, //rgb(175, 135, 215)
    x141 = 141, //rgb(175, 135, 255)
    x142 = 142, //rgb(175, 175, 0)
    x143 = 143, //rgb(175, 175, 95)
    x144 = 144, //rgb(175, 175, 135)
    x145 = 145, //rgb(175, 175, 175)
    x146 = 146, //rgb(175, 175, 215)
    x147 = 147, //rgb(175, 175, 255)
    x148 = 148, //rgb(175, 215, 0)
    x149 = 149, //rgb(175, 215, 95)
    x150 = 150, //rgb(175, 215, 135)
    x151 = 151, //rgb(175, 215, 175)
    x152 = 152, //rgb(175, 215, 215)
    x153 = 153, //rgb(175, 215, 255)
    x154 = 154, //rgb(175, 255, 0)
    x155 = 155, //rgb(175, 255, 95)
    x156 = 156, //rgb(175, 255, 135)
    x157 = 157, //rgb(175, 255, 175)
    x158 = 158, //rgb(175, 255, 215)
    x159 = 159, //rgb(175, 255, 255)
    x160 = 160, //rgb(215, 0, 0)
    x161 = 161, //rgb(215, 0, 95)
    x162 = 162, //rgb(215, 0, 135)
    x163 = 163, //rgb(215, 0, 175)
    x164 = 164, //rgb(215, 0, 215)
    x165 = 165, //rgb(215, 0, 255)
    x166 = 166, //rgb(215, 95, 0)
    x167 = 167, //rgb(215, 95, 95)
    x168 = 168, //rgb(215, 95, 135)
    x169 = 169, //rgb(215, 95, 175)
    x170 = 170, //rgb(215, 95, 215)
    x171 = 171, //rgb(215, 95, 255)
    x172 = 172, //rgb(215, 135, 0)
    x173 = 173, //rgb(215, 135, 95)
    x174 = 174, //rgb(215, 135, 135)
    x175 = 175, //rgb(215, 135, 175)
    x176 = 176, //rgb(215, 135, 215)
    x177 = 177, //rgb(215, 135, 255)
    x178 = 178, //rgb(215, 175, 0)
    x179 = 179, //rgb(215, 175, 95)
    x180 = 180, //rgb(215, 175, 135)
    x181 = 181, //rgb(215, 175, 175)
    x182 = 182, //rgb(215, 175, 215)
    x183 = 183, //rgb(215, 175, 255)
    x184 = 184, //rgb(215, 215, 0)
    x185 = 185, //rgb(215, 215, 95)
    x186 = 186, //rgb(215, 215, 135)
    x187 = 187, //rgb(215, 215, 175)
    x188 = 188, //rgb(215, 215, 215)
    x189 = 189, //rgb(215, 215, 255)
    x190 = 190, //rgb(215, 255, 0)
    x191 = 191, //rgb(215, 255, 95)
    x192 = 192, //rgb(215, 255, 135)
    x193 = 193, //rgb(215, 255, 175)
    x194 = 194, //rgb(215, 255, 215)
    x195 = 195, //rgb(215, 255, 255)
    x196 = 196, //rgb(255, 0, 0)
    x197 = 197, //rgb(255, 0, 95)
    x198 = 198, //rgb(255, 0, 135)
    x199 = 199, //rgb(255, 0, 175)
    x200 = 200, //rgb(255, 0, 215)
    x201 = 201, //rgb(255, 0, 255)
    x202 = 202, //rgb(255, 95, 0)
    x203 = 203, //rgb(255, 95, 95)
    x204 = 204, //rgb(255, 95, 135)
    x205 = 205, //rgb(255, 95, 175)
    x206 = 206, //rgb(255, 95, 215)
    x207 = 207, //rgb(255, 95, 255)
    x208 = 208, //rgb(255, 135, 0)
    x209 = 209, //rgb(255, 135, 95)
    x210 = 210, //rgb(255, 135, 135)
    x211 = 211, //rgb(255, 135, 175)
    x212 = 212, //rgb(255, 135, 215)
    x213 = 213, //rgb(255, 135, 255)
    x214 = 214, //rgb(255, 175, 0)
    x215 = 215, //rgb(255, 175, 95)
    x216 = 216, //rgb(255, 175, 135)
    x217 = 217, //rgb(255, 175, 175)
    x218 = 218, //rgb(255, 175, 215)
    x219 = 219, //rgb(255, 175, 255)
    x220 = 220, //rgb(255, 215, 0)
    x221 = 221, //rgb(255, 215, 95)
    x222 = 222, //rgb(255, 215, 135)
    x223 = 223, //rgb(255, 215, 175)
    x224 = 224, //rgb(255, 215, 215)
    x225 = 225, //rgb(255, 215, 255)
    x226 = 226, //rgb(255, 255, 0)
    x227 = 227, //rgb(255, 255, 95)
    x228 = 228, //rgb(255, 255, 135)
    x229 = 229, //rgb(255, 255, 175)
    x230 = 230, //rgb(255, 255, 215)
    x231 = 231, //rgb(255, 255, 255)
    x232 = 232, //rgb(8, 8, 8)
    x233 = 233, //rgb(18, 18, 18)
    x234 = 234, //rgb(28, 28, 28)
    x235 = 235, //rgb(38, 38, 38)
    x236 = 236, //rgb(48, 48, 48)
    x237 = 237, //rgb(58, 58, 58)
    x238 = 238, //rgb(68, 68, 68)
    x239 = 239, //rgb(78, 78, 78)
    x240 = 240, //rgb(88, 88, 88)
    x241 = 241, //rgb(98, 98, 98)
    x242 = 242, //rgb(108, 108, 108)
    x243 = 243, //rgb(118, 118, 118)
    x244 = 244, //rgb(128, 128, 128)
    x245 = 245, //rgb(138, 138, 138)
    x246 = 246, //rgb(148, 148, 148)
    x247 = 247, //rgb(158, 158, 158)
    x248 = 248, //rgb(168, 168, 168)
    x249 = 249, //rgb(178, 178, 178)
    x250 = 250, //rgb(188, 188, 188)
    x251 = 251, //rgb(198, 198, 198)
    x252 = 252, //rgb(208, 208, 208)
    x253 = 253, //rgb(218, 218, 218)
    x254 = 254, //rgb(228, 228, 228)
    x255 = 255, //rgb(238, 238, 238)
};

const AnsiColor = union(enum) {
    pub const RGB = struct {
        r: u3 = 0,
        g: u3 = 0,
        b: u3 = 0,
    };

    color: BasicColor,
    rgb: RGB,
    gray: u8,
    code: u8,

    pub fn of(comptime def: anytype) AnsiColor {
        return comptime blk: {
            switch (@typeInfo(@TypeOf(def))) {
                .enum_literal => {
                    if (@hasField(BasicColor, @tagName(def))) {
                        break :blk .{ .color = std.enums.nameCast(BasicColor, @tagName(def)) };
                    } else if (@hasField(XtermColor, @tagName(def))) {
                        break :blk .{ .code = @intFromEnum(@field(XtermColor, @tagName(def))) };
                    } else {
                        @compileError("unknow color: ." ++ @tagName(def));
                    }
                },
                else => {
                    if (getDef(def, .gray)) |gray| {
                        if (gray < 0 or gray > 23) @compileError(".gray must in range [0, 23].");
                        break :blk .{ .gray = gray };
                    }
                    var rgb: RGB = .{};
                    if (getDef(def, .r)) |r| {
                        if (r < 0 or r > 5) @compileError(".r must in range [0, 5].");
                        rgb.r = r;
                    }
                    if (getDef(def, .g)) |g| {
                        if (g < 0 or g > 5) @compileError(".g must in range [0, 5].");
                        rgb.g = g;
                    }
                    if (getDef(def, .b)) |b| {
                        if (b < 0 or b > 5) @compileError(".b must in range [0, 5].");
                        rgb.b = b;
                    }
                    break :blk .{ .rgb = rgb };
                },
            }
        };
    }

    pub fn ansiCode(self: AnsiColor, is_foreground: bool) u8 {
        switch (std.meta.activeTag(self)) {
            .color => return self.color.ansiCode(is_foreground),
            .rgb => return 16 + 36 * @as(u8, self.rgb.r) + 6 * @as(u8, self.rgb.g) + self.rgb.b,
            .gray => return 232 + self.gray,
            .code => return self.code,
        }
    }
};

test "AnsiColor" {
    const t = std.testing;

    var color = AnsiColor.of(.red);
    try t.expect(std.meta.activeTag(color) == .color);
    try t.expect(color.color == .red);
    try t.expect(color.color.ansiCode(true) == 31);

    color = AnsiColor.of(.{ .r = 3 });
    try t.expect(std.meta.activeTag(color) == .rgb);
    try t.expect(color.rgb.r == 3);

    color = AnsiColor.of(.{ .gray = 23 });
    try t.expect(color.ansiCode(true) == 255);
}

const TextStyle = enum(u8) {
    bold = 1,
    italic = 3,
    underline = 4,
    slowblink = 5,
    rapidblink = 6,
    reverse = 7,
    invisible = 8,
    strikethrough = 9,
};

pub fn ansiSeqStart(comptime def: anytype) []const u8 {
    return comptime blk: {
        if (@TypeOf(def) == @TypeOf(.{})) break :blk "";

        var buf: [128]u8 = undefined;
        var stream = std.io.fixedBufferStream(&buf);
        var writer = stream.writer();
        _ = writer.write("\x1b[") catch @panic("FMT ERROR");
        if (getDef(def, .fg)) |fgdef| {
            const fg = AnsiColor.of(fgdef);
            if (std.meta.activeTag(fg) == .color) {
                writer.print("{};", .{fg.ansiCode(true)}) catch @panic("FMT ERROR");
            } else {
                writer.print("38;5;{};", .{fg.ansiCode(true)}) catch @panic("FMT ERROR");
            }
        }
        if (getDef(def, .bg)) |bgdef| {
            const bg = AnsiColor.of(bgdef);
            if (std.meta.activeTag(bg) == .color) {
                writer.print("{};", .{bg.ansiCode(false)}) catch @panic("FMT ERROR");
            } else {
                writer.print("48;5;{};", .{bg.ansiCode(false)}) catch @panic("FMT ERROR");
            }
        }
        if (getDef(def, .style)) |style| {
            for (style) |field| {
                if (!@hasField(TextStyle, @tagName(field))) @compileError("unknown style: ." ++ @tagName(field));
                writer.print("{};", .{@intFromEnum(std.enums.nameCast(TextStyle, @tagName(field)))}) catch @panic("FMT ERROR");
            }
        }
        var seq = stream.getWritten();
        seq[seq.len - 1] = 'm';
        break :blk std.fmt.comptimePrint("{s}", .{seq});
    };
}

pub fn ansiSeqEnd(comptime def: anytype) []const u8 {
    return comptime blk: {
        if (@TypeOf(def) == @TypeOf(.{})) break :blk "";
        break :blk "\x1b[0m";
    };
}

pub const print = blk: {
    if (builtin.mode == .Debug) {
        break :blk (struct {
            pub fn func(style: anytype, comptime fmt: []const u8, arg: anytype) void {
                if (getDef(style, .prefix)) |prefix| {
                    std.debug.print("{s}{s}{s}" ++ fmt, .{ansiSeqStart(style)} ++ .{prefix} ++ .{ansiSeqEnd(style)} ++ arg);
                } else {
                    std.debug.print("{s}" ++ fmt ++ "{s}", .{ansiSeqStart(style)} ++ arg ++ .{ansiSeqEnd(style)});
                }
            }
        }).func;
    } else {
        break :blk (struct {
            pub fn func(_: anytype, comptime _: []const u8, _: anytype) void {}
        }).func;
    }
};

pub fn bufPrint(buf: []u8, style: anytype, comptime fmt: []const u8, arg: anytype) std.fmt.BufPrintError![]u8 {
    if (getDef(style, .prefix)) |prefix| {
        return try std.fmt.bufPrint(buf, "{s}{s}{s}" ++ fmt, .{ansiSeqStart(style)} ++ .{prefix} ++ .{ansiSeqEnd(style)} ++ arg);
    } else {
        return try std.fmt.bufPrint(buf, "{s}" ++ fmt ++ "{s}", .{ansiSeqStart(style)} ++ arg ++ .{ansiSeqEnd(style)});
    }
}

test "xterm256.print" {
    const t = std.testing;

    const style = .{ .fg = .red, .style = .{ .bold, .underline, .slowblink } };
    try t.expectEqualStrings(ansiSeqStart(style), "\x1b[31;1;4;5m");

    var buf: [1024]u8 = undefined;
    const msg = bufPrint(&buf, .{ .fg = .x222, .prefix = "msg", .style = .{.underline} }, ": {s}", .{"buf msg"}) catch @panic("FMT");
    std.debug.print("{s}\n", .{msg});

    print(.{ .fg = .bright_green, .style = .{.bold} }, "Hello Color World.\n", .{});

    const complexStyle = .{
        .fg = .bright_yellow,
        .bg = .{ .b = 5 },
        .style = .{ .bold, .strikethrough, .rapidblink },
        .prefix = "complex",
    };
    print(complexStyle, ": Hello\n", .{});

    _ = try bufPrint(&buf, .{ .fg = .red }, "Hello", .{});
}

// === def utils ===
pub fn getDef(def: anytype, comptime field: anytype) t: {
    switch (hasField(@TypeOf(def), field)) {
        true => break :t ReturnType(@TypeOf(def), field),
        false => break :t @TypeOf(null),
    }
} {
    return switch (hasField(@TypeOf(def), field)) {
        true => fieldValue(def, field),
        false => null,
    };
}

fn DefFieldType(comptime T: type, comptime field: anytype) type {
    switch (@typeInfo(@TypeOf(field))) {
        .enum_literal => return @FieldType(T, @tagName(field)),
        else => return @FieldType(T, field),
    }
}

fn ReturnType(comptime T: type, comptime field: anytype) type {
    const FT = DefFieldType(T, @tagName(field));
    switch (@typeInfo(FT)) {
        .optional => return FT,
        else => return ?FT,
    }
}

inline fn hasField(comptime T: type, comptime field: anytype) bool {
    switch (@typeInfo(@TypeOf(field))) {
        .enum_literal => return @hasField(T, @tagName(field)),
        else => return @hasField(T, field),
    }
}

fn fieldValue(lhs: anytype, comptime field: anytype) ReturnType(@TypeOf(lhs), field) {
    switch (@typeInfo(@TypeOf(field))) {
        .enum_literal => return @field(lhs, @tagName(field)),
        else => return @field(lhs, field),
    }
}
