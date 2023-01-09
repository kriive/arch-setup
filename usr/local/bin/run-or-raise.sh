#!/usr/bin/env bash

PROG=$( basename $0 )

target="$1"
class="$2"
runstring="$3"

[[ "$class" ]] || class="$target"
[[ "$runstring" ]] || runstring="$target"

pkill -0 $target || {
    swaymsg exec -- $runstring
    exit 0
}

swaymsg "[app_id=$target] focus" &>/dev/null || {
    # could be Xwayland app:
    swaymsg "[class=$class] focus" &>/dev/null
}

exit 0

