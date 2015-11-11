set -l tofishdir ~/.tofish

complete -c to -n '__fish_use_subcommand' -x -a "add" -d 'Create a bookmark'
complete -c to -n '__fish_use_subcommand' -x -a "rm" -d 'Remove a bookmark'
complete -c to -n '__fish_use_subcommand' -x -a "ls" -d 'Lists all bookmarks'
complete -c to -n '__fish_use_subcommand' -x -a "list" -d 'Lists all bookmarks'
complete -c to -n '__fish_use_subcommand' -x -a "mv" -d 'Rename a bookmark'
complete -c to -n '__fish_use_subcommand' -x -a "rename" -d 'Rename a bookmark'
complete -c to -n '__fish_use_subcommand' -x -a "help" -d 'Show Help'

complete -c to -f -a "(ls -1 '$tofishdir')" -d 'Bookmark'

for i in add rm mv ls help
	complete -c to -n "contains '$i' (commandline -poc)" -x -a "(ls -1 '$tofishdir')" -d 'Bookmark'
end
