# to-fish

A directory bookmarking tool for fish-shell.

## Usage

`to` puts bookmarks in the directory `~/.tofish`

Use `set -U TO_DIR` to change where bookmarks are stored.

```txt
$ to help
Usage:
 to (BOOKMARK|DIR)         Go to BOOKMARK or DIR
 to add [BOOKMARK] [DEST]  Create a BOOKMARK for DEST
                             Default BOOKMARK: name of current directory
                             Default DEST: path to current directory
 to ls                     List all bookmarks
 to mv OLD NEW             Change the name of a bookmark from OLD to NEW
 to rm BOOKMARK            Remove BOOKMARK
 to clean                  Remove bookmarks that have a missing destination
 to resolve BOOKMARK       Print the destination of a bookmark
 to help                   Show this message
```

## Installation

### [Fisher](https://github.com/jorgebucaran/fisher) (recommended)

```txt
fisher install joehillen/to-fish
```

### [fundle](https://github.com/tuvistavie/fundle)

Add the following to `~/.config/fish/config.fish` and run `fundle install`.

```txt
fundle plugin joehillen/to-fish
```

## Manually

Run `make`
