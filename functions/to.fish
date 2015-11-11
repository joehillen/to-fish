# Display general usage
function __to_usage
  echo 'Usage:'
  echo ' to <bookmark>              # Go to <bookmark>'
  echo ' to add <bookmark>          # Create a new bookmark with name <bookmark>'
  echo '                            # that points to the current directory'
  echo ' to rm <bookmark>           # Remove <bookmark>'
  echo ' to (ls|list)               # List all bookmarks'
  echo ' to (mv|rename) <old> <new> # Change the name of a bookmark'
  echo '                            # from <old> to <new>'
  echo ' to help                    # Show this message'
  return 1
end


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

  if test (count $argv) -lt 1
    __to_usage
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
      for b in (ls -1 $tofishdir)
         echo ">> $b"
         cat $tofishdir/$b
         echo
      end

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

    case help
      __to_usage
      return 0

    case '*'
      if test -f "$tofishdir/$argv[1]"
        . "$tofishdir/$argv[1]"
      else
        echo "The bookmark '$argv[1]' does not exist."
        return 1
      end
  end
end
