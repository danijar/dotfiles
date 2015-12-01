#!/bin/bash

repo=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")
echo "Found repository at $repo"

# link_dir(repo_dir, system_dir)
# Crate symlinks in the system dir to all files inside the repository dir.
link_dir() {
    find $repo/$1 -type f -print0 | while IFS= read -r -d '' file; do
        link=$2/${file#$repo/$1/}
        echo $link
        if [ ! -L $link ]; then
            mkdir -p "$(dirname "$link")"
            ln -s "$file" "$link"
        fi
    done;
}

link_dir home ~
