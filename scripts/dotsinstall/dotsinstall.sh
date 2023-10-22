#!/usr/bin/env bash

directory=$(dirname "$(realpath "$0")")
ITEMS_FILE="$directory/items.ini"

subst() {
    # In case envsubst is not available, use sed
    if $(command -v envsubst); then
        envsubst
    else
        sed "s/\$HOME/${HOME//\//\\/}/"
    fi
}

declare -A table
declare -a sections=()

section_i=0
while IFS= read -r line; do
    if [[ $line =~ ^\[([a-z-]+)\]$ ]]; then
        section=${BASH_REMATCH[1]}

        sections[${#sections[@]}]=$section

        section_i=$((section_i + 1))
    else
        [[ $line =~ ^\[([a-z]+)\]$ ]]
        IFS="=" read -a temp <<<"$line"
        key=${temp[0]}
        value=${temp[1]}
        table[$section,$key]=$value
    fi
done < $ITEMS_FILE

if [ $# -ne 1 ]; then
    echo "usage: ./install <program>"
    exit
fi

selected="$1"
src=${table[$selected,src]}
dest=${table[$selected,dest]}

if [ -z "$src" ]; then
    echo "No valid entry selected!"
    exit
fi

src_expanded=$(realpath "$src")
dest_expanded=$(subst <<< "$dest")

set -x
ln --symbolic --no-target-directory --verbose "$src_expanded" "$dest_expanded"

