function cdd --description 'List directories for cd numeric selection'
    echo "Available directories in "(pwd)":"
    echo "----------------------------------------"

    set -l dirs
    # Only get non-hidden directories
    for dir in */
        if test -d "$dir"
            set -l name (string replace -r '/$' '' -- $dir)
            set -a dirs $name
        end
    end

    if test (count $dirs) -eq 0
        echo "No subdirectories found."
        return
    end

    set -l i 1
    for dir in $dirs
        printf "%2d: %s\n" $i $dir
        set i (math $i + 1)
    end

    echo "----------------------------------------"
enda
