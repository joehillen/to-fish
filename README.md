# to-fish

A bookmarking tool for Fish shell. This is a [fundle](https://github.com/tuvistavie/fundle) package.

## Installation

### Using [fundle](https://github.com/tuvistavie/fundle) (recommended)

Add

```
fundle plugin 'joehillen/to-fish'
```

to your `config.fish` and run `fundle install`.

### Manually

Put `functions/to.fish` in `~/.config/fish/functions/` directory,
and put `completions/to.fish` in `~/.config/fish/completions/`.

or run `make`

## Usage

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
