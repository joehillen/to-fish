# to-fish

Bookmark directories in fish-shell

# Usage

`to` puts bookmarks in the directory `~/.tofish`

```
$ to help
Usage:
 to <bookmark>              # Go to <bookmark>
 to add [<bookmark>]        # Create a new bookmark with name <bookmark>
                            # that points to the current directory.
                            # If no <bookmark> is given,
                            # the current directory name is used.
 to rm <bookmark>           # Remove <bookmark>
 to (ls|list)               # List all bookmarks
 to (mv|rename) <old> <new> # Change the name of a bookmark
                            # from <old> to <new>
 to help                    # Show this message
```

# Installation
## [Fisher](https://github.com/jorgebucaran/fisher) (recommended)

```
fisher add joehillen/to-fish
```

## [fundle](https://github.com/tuvistavie/fundle)

Add the following to `~/.config/fish/config.fish` and run `fundle install`.

```
fundle plugin joehillen/to-fish
```

## Manually

Run `make` or

```
cp functions/ev.fish ~/.config/fish/functions/
cp completions/ev.fish ~/.config/fish/completions/
```


