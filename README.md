# what-size.yazi

A plugin for [yazi](https://github.com/sxyazi/yazi) to calculate the size of the current selection or the current working directory (if no selection is made).

> Fork from https://github.com/pirafrank/what-size.yazi to make this plugin work with MacOS.  
> As mentioned in https://github.com/pirafrank/what-size.yazi/issues/3, the `-b` option does not exist on MacOS.
> In this fork, the size is calculated for the hovered file by default.

## Compatibility

- yazi `v25.2.7`

## Requirements

- `du` on macOS.

## Installation

```sh
ya pack -a 'ETLaurent/what-size'
```

## Usage

Add this to your `~/.config/yazi/keymap.toml`:

```toml
[[manager.prepend_keymap]]
on   = "b"
run  = "plugin what-size"
desc = "Calc size of selection or cwd"

[[manager.prepend_keymap]]
on   = "B"
run  = "plugin what-size"
desc = "Calc size of selection or cwd"
```

> "b" and "B" as "Bytes" since they're free... they can be changed.

## License

MIT
