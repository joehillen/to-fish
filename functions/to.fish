function to -d 'Bookmarking system.'
	set -l tofishdir ~/.tofish

	# Create tofish directory
	if not test -d "$tofishdir"
		if mkdir "$tofishdir"
			echo "Created bookmark directory '$tofishdir'."
		else
			echo "Failed to Create bookmark directory '$tofishdir'."
			return 1
		end
	end

	# Display general usage
	if test (count $argv) -lt 1
		echo 'Usage: to <bookmark>'
		echo '       to <command> [command arguments]'
		echo 'Where <command> is one of: add, rm, list, rename'
		return 1
	end

	# Catch usage errors
	switch $argv[1]
		case add rm
			if not test (count $argv) -ge 2
				echo "Usage: to $argv[1] BOOKMARK"
				return 1
			end

		case mv rename
			if not test (count $argv) -ge 3
				echo "Usage: to $argv[1] SOURCE DEST"
				return 1
			end
	end

	switch $argv[1]
		case add # Add a bookmark
			if test -f "$tofishdir/$argv[2]"
				echo "Error: The bookmark '$argv[2]' already exists."
				echo "Use `to rm '$argv[2]'` to remove it first."
				return 1
			end

			echo "cd \""(pwd)"\"" > "$tofishdir/$argv[2]"

			echo "Added bookmark '$argv[2]'."

		case rm # Remove a bookmark
			if rm -f "$tofishdir/$argv[2]"
				echo "Removed bookmark '$argv[2]'."
			else
				echo "The bookmark '$argv[2]' does not exist."
				return 1
			end

		case ls list # List all bookmarks
			ls "$tofishdir"

		case mv rename # Rename a bookmark
			if not test -f "$tofishdir/$argv[2]"
				echo "The bookmark '$argv[2]' does not exist."
				return 1
			else if test -f "$tofishdir/$argv[3]"
				echo "Error: The destination bookmark '$argv[3]' already exists."
				echo "Use `to rm '$argv[3]'` to remove it first."
				return 1
			end

			mv "$tofishdir/$argv[2]" "$tofishdir/$argv[3]"

		# Bonus commands!
		case home
			cd

		case '*'
			if test -f "$tofishdir/$argv[1]"
				. "$tofishdir/$argv[1]"
			else
				echo "The bookmark '$argv[1]' does not exist."
				return 1
			end
	end
end
