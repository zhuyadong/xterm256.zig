[中文](README.CN.md) | [English](README.md)
# Print Text with `xterm256` Colors and Styles
## Install
In the project root directory:
```shell
zig fetch "git+https://github.com/zhuyadong/xterm256.zig" --save=xterm256
```
If you want to install a specific version:
```shell
zig fetch "git+https://github.com/zhuyadong/xterm256.zig#<ref id>" --save=xterm256
```

## Usage Examples
```zig
const xterm = @import("xterm256");

// Print "Hello" in red
xterm.print(.{.fg = .red}, "Hello", .{});

// Print "Hello" in red with a white background
xterm.print(.{.fg = .{.r=5}, .bg = .white}, "Hello", .{});

// Print "Hello" with color number 222
xterm.print(.{.fg = .x222}, "Hello", .{});

// Print "Hello" in bold red
xterm.print(.{.fg = .red, .style = .{.bold}}, "Hello", .{});

// If there is a `prefix`, only the `prefix` part will be colored
xterm.print(.{.fg = .red, .prefix="error:"}, " something wrong.", .{});

// Save the sequence to print "Hello" in red to buf
var buf: [128]u8 = undefined;
_ = try xterm.bufPrint(&buf, .{.fg = .red}, "Hello", .{});

// Complex style
const complexStyle = .{
    .fg = .x222,
    .bg = .{.b = 5, .g = 5},
    .style = .{.bold, .underline},
    .prefix = "complex:",
};
xterm.print(complexStyle, "Hello", .{});
```
## Style Definition Format
```zig
.{
    .fg = <color>,
    .bg = <color>,
    .style = .{.style1, .style2 ...},
    .prefix="prefix text"
}
```
Where `<color>` can be one of the following formats:
- .<color_name>
- .{.r=[0,5], .g=[0-5], .b=[0-5]}
- .{.gray=[0-23]}
> In the `rgb` format, you can omit 1-2 of `r`, `g`, `b`

`<color_name>` includes the following items:
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

`style` includes the following items:
- .bold
- .italic
- .underline
- .slowblink
- .rapidblink
- .reverse
- .invisible
- .strikethrough