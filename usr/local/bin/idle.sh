#!/bin/sh

swayidle \
	timeout 600 'chayang && /usr/local/bin/lock.sh' \
	timeout 900 'swaymsg "output * dpms off"' \
	resume 'swaymsg "output * dpms on"' \
	before-sleep '/usr/local/bin/lock.sh'
