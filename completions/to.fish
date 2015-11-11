set -l tofishdir ~/.tofish

complete -c to -n '__fish_use_subcommand' -x -a add -d 'Adds a bookmark'
complete -c to -n '__fish_use_subcommand' -x -a "rm" -d 'Removes a bookmark'
complete -c to -n '__fish_use_subcommand' -x -a "ls" -d 'Lists all bookmarks'
complete -c to -n '__fish_use_subcommand' -x -a "mv" -d 'Renames a bookmark'

complete -c to -f -a "(ls -1 '$tofishdir')" -d 'Bookmark'

for i in add rm mv
	complete -c to -n "contains '$i' (commandline -poc)" -x -a "(ls -1 '$tofishdir')" -d 'Bookmark'
end
