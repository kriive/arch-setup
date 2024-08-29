#!/bin/sh

command_args=()

while [ "$#" -gt 0 ]; do
    if [ "$1" = "--print-format" ]; then
        # Ignore --print-format and its string arg
        shift
        shift
    else
        command_args+=("$1")
        shift
    fi
done

echo paru "${command_args[@]}"
