set -l tofishdir ~/.tofish

complete -c to -n '__fish_use_subcommand' -x -a "add" -d 'Create a bookmark'
complete -c to -n '__fish_use_subcommand' -x -a "rm" -d 'Remove a bookmark'
complete -c to -n '__fish_use_subcommand' -x -a "ls" -d 'Lists all bookmarks'
complete -c to -n '__fish_use_subcommand' -x -a "list" -d 'Lists all bookmarks'
complete -c to -n '__fish_use_subcommand' -x -a "mv" -d 'Rename a bookmark'
complete -c to -n '__fish_use_subcommand' -x -a "rename" -d 'Rename a bookmark'
complete -c to -n '__fish_use_subcommand' -x -a "help" -d 'Show Help'

if test -d "$tofishdir"
  for b in (ls -a1 $tofishdir | grep -xv '.' | grep -xv '..')
    complete -c to -f -a "$b" -d 'Bookmark'
  end
end
