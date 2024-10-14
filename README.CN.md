[中文](README.CN.md) | [English](README.md)
# xterm256.zig: 打印`xterm256`颜色和风格的文字

## 使用举例
```zig
const xterm = @import("xterm256");

// 用红色打印 "Hello"
xterm.print(.{.fg = .red}, "Hello", .{});

// 用红色打印 "Hello", 背景白色
xterm.print(.{.fg = .{.r=5}, .bg = .white}, "Hello", .{});

// 用第222号颜色打印 "Hello"
xterm.print(.{.fg = .x222}, "Hello", .{});

// 用红色粗体打印 "Hello"
xterm.print(.{.fg = .red, .style = .{.bold}}, "Hello", .{});

// 如果有`prefix`，则只有`prefix`部分有颜色
xterm.print(.{.fg = .red, .prefix="error:"}, " something wrong.", .{});

// 把用红色打印 "Hello" 的字符串序列保存到buf中
var buf: [128]u8 = undefined;
_ = try xterm.bufPrint(&buf, .{.fg = .red}, "Hello", .{});

// 复杂风格
const complexStyle = .{
    .fg = .x222,
    .bg = .{.b = 5, .g = 5},
    .style = .{.bold, .underline},
    .prefix = "complex:",
};
xterm.print(complexStyle, "Hello", .{});
```
## 风格定义格式
```zig
.{
    .fg = <color>,
    .bg = <color>,
    .style = .{.style1, .style2 ...},
    .prefix="prefix text"
}
```
其中 `<color>` 格式为以下之一：
- .<color_name>
- .{.r=[0,5], .g=[0-5], .b=[0-5]}
- .{.gray=[0-23]}
>`rgb` 格式中可以省略`r`,`g`,`b`中1-2个

`<color_name>`有以下条目：
- .x[16-255]
- .black
- .red
- .green
- .yellow
- .blue
- .magenta
- .cyan
- .white
- .bright_black
- .bright_red
- .bright_green
- .bright_yellow
- .bright_blue
- .bright_magenta
- .bright_cyan
- .bright_white

`style`有以下条目 ：
- .bold
- .itlic
- .underline
- .slowblink
- .rapidblink
- .reverse
- .invisible
- .strikethrough