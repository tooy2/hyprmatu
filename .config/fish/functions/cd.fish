function cd --description 'Extended cd: supports numeric index to cd into Nth directory'
    # No args: default behavior
    if test (count $argv) -eq 0
        builtin cd
        return
    end

    set -l first $argv[1]

    # If first arg is a positive integer, treat it as an index into subdirectories
    if string match -qr '^[0-9]+$' -- $first
        set -l dirs
        # Only get non-hidden directories
        for dir in */
            if test -d "$dir"
                set -l name (string replace -r '/$' '' -- $dir)
                set -a dirs $name
            end
        end

        set -l n (math $first)
        set -l count_dirs (count $dirs)
        if test $n -gt 0; and test $n -le $count_dirs
            set -l target_dir $dirs[$n]
            echo "Changing to: $target_dir"
            builtin cd -- "$target_dir"
            return
        else
            echo "Error: Invalid directory number. Use 'cdd' to see available directories."
            return 1
        end
    end

    # Fallback to normal cd behavior for non-numeric arguments
    builtin cd -- $argv
end
