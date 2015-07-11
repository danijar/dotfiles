#!/bin/sh

repo=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..

# update_dir(repo_dir, system_dir)
# Update all files inside the specified directory with their current versions
# on the system.
update_dir() {
    find $repo/$1 -type f -print0 | while IFS= read -r -d '' repo_file; do
        system_file=$2/${repo_file#$repo/$1/}
        echo $system_file
        cp -af "$system_file" "$repo_file"
    done;
}

update_dir home ~
update_dir etc /etc
update_dir boot /boot
