#!/usr/bin/env bash

matchNumber=$(find . \( ! -regex '.*/\..*' \) -type d | grep -c "$1$")
matches=$(find . \( ! -regex '.*/\..*' \) -type d | grep "$1$")

if [[ matchNumber -eq 1 ]]; then
    cd "$matches"
else
    echo $matches | tr '\n' ' '
    echo
fi

# echo "$matchNumber"
# echo "$matches"