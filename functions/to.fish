# Display general usage
function __to_usage
  echo 'Usage:'
  echo ' to <bookmark>              # Go to <bookmark>'
  echo ' to add [<bookmark>]        # Create a new bookmark with name <bookmark>'
  echo '                            # that points to the current directory.'
  echo '                            # If no <bookmark> is given,'
  echo '                            # the current directory name is used.'
  echo ' to rm <bookmark>           # Remove <bookmark>'
  echo ' to (ls|list)               # List all bookmarks'
  echo ' to (mv|rename) <old> <new> # Change the name of a bookmark'
  echo '                            # from <old> to <new>'
  echo ' to help                    # Show this message'
  return 1
end

function __to_update_bookmark_completions
  set -l tofishdir ~/.tofish
  if test -d "$tofishdir"
    for b in (/bin/ls -a1 $tofishdir | grep -xv '.' | grep -xv '..')
      complete -c to -f -a "$b" -d 'Bookmark'
    end
  end
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
    case rm
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
      if test (count $argv) -eq 1
        set bookmarkname (basename (pwd))
      else
        set bookmarkname $argv[2]
      end

      if test -h "$tofishdir/$bookmarkname"
        echo "Error: The bookmark '$bookmarkname' already exists."
        echo "Use `to rm '$bookmarkname'` to remove it first."
        return 1
      else
        ln -s (pwd) "$tofishdir/$bookmarkname"
      end

      echo "Added bookmark '$bookmarkname'."
      __to_update_bookmark_completions

    case rm # Remove a bookmark
      if rm -f "$tofishdir/$argv[2]"
        echo "Removed bookmark '$argv[2]'."
        complete -e -c to -f -a "$argv[2]" -d 'Bookmark'
        __to_update_bookmark_completions
      else
        echo "The bookmark '$argv[2]' does not exist."
        return 1
      end

    case ls list # List all bookmarks
      for b in (/bin/ls -a1 $tofishdir)
        if test "$b" != '.' -a "$b" != '..'
          set -l dest (readlink "$tofishdir/$b")
          echo "$b -> $dest"
        end
      end

    case mv rename # Rename a bookmark
      if not test -h "$tofishdir/$argv[2]"
        echo "The bookmark '$argv[2]' does not exist."
        return 1
      else if test -h "$tofishdir/$argv[3]"
        echo "Error: The destination bookmark '$argv[3]' already exists."
        echo "Use `to rm '$argv[3]'` to remove it first."
        return 1
      end

      mv "$tofishdir/$argv[2]" "$tofishdir/$argv[3]"
      complete -e -c to -f -a "$argv[2]" -d 'Bookmark'
      __to_update_bookmark_completions

    case help
      __to_usage
      return 0

    case '*'
      if test -h "$tofishdir/$argv[1]"
        echo "cd (readlink \"$tofishdir/$argv[1]\")" | source -
      else
        echo "The bookmark '$argv[1]' does not exist."
        return 1
      end
  end
end
