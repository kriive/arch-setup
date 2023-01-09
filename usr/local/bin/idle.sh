#!/bin/sh

swayidle \
	timeout 600 '~/.config/sway/lock.sh' \
	timeout 900 'swaymsg "output * dpms off"' \
	resume 'swaymsg "output * dpms on"' \
	before-sleep '~/.config/sway/lock.sh'
